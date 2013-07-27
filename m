Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:59038 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KNz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jul 2013 06:13:55 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so1963129eek.7
        for <linux-pwm@vger.kernel.org>; Sat, 27 Jul 2013 03:13:53 -0700 (PDT)
Date: Sat, 27 Jul 2013 12:18:24 +0200
From: Johannes Thumshirn <morbidrsa@gmail.com>
Subject: Determining wich PWM to use
Message-ID: <20130727101824.GA11956@sauron.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Johannes Thumshirn <morbidrsa@gmail.com>

Hi list,

I'm currently working on a pwm driver for the BCM2853 (the SoC used on the
RaspberryPi). It has two PWM modules, so my question is, how do I determine
which PWM to use in the .enable, .disable and .configure functions?

If someone wants to have have a look at the preliminary code (far from being
submittable and only compile tested) it can be found here:

https://github.com/morbidrsa/linux/blob/rpi-pwm/drivers/pwm/pwm-bcm2835.c

2nd short question, is it considered good practice to encapsulate registers in
structs? I've seen this a lot on powerpc code.

Thanks for your help.

Johannes
