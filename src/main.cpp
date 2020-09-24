// Mbed CMake Template
// Copyright 2020 Ladislas de Toldi (ladislas [at] detoldi.me)
// SPDX-License-Identifier: Apache-2.0

#include "HelloWorld.h"
#include "mbed.h"

HelloWorld hello;

static BufferedSerial serial(USBTX, USBRX, 115200);

constexpr uint8_t buff_size = 80;
char buff[buff_size] {};

int main(void)
{
	auto start = Kernel::Clock::now();

	hello.start();

	while (true) {
		auto t	   = Kernel::Clock::now() - start;
		int c_size = sprintf(buff, "A message from your board --> \"%s\" at %i s\n", hello.world, int(t.count() / 1000));

		serial.write(buff, c_size);
		rtos::ThisThread::sleep_for(1s);
	}

	return 0;
}
