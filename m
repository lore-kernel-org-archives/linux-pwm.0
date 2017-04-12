From: Philip Munts <phil@munts.net>
Subject: BUG: No hotplug event for PCA9685 PWM output devices
Date: Wed, 12 Apr 2017 12:51:37 +0200
Message-ID: <992ce3b8-b780-630c-5fb9-725a6c54faf1@munts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:49306
        "EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752336AbdDLK72 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2017 06:59:28 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

I am using a PCA9685 I2C PWM controller on a Raspberry Pi 2.  When I instantiate the PCA9685 device with "echo pca9685 0x40 >new_device" in the I2C bus device directory, I get a hotplug event for pwmchip0, as expected.  When I manually initiate a hotplug event with "echo add >uevent" from the pwmchip0 device directory, I get another hotplug event for pwmchip0, also as expected.

However, when I create a PWM output device with "echo 0 >export" from the pwmchip0 device directory, the PWM output device subdirectory pwm0 is created, including the uevent file, but no hotplug event is generated for pwm0.

Furthermore, when I attempt to manually initiate a hotplug event for pwm0 by running "echo add >uevent" from the pwm0 subdirectory, no hotplug event is generated.

Philip Munts
phil@munts.net
