From: Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: quck help on PDM DAC driver
Date: Sun, 21 Sep 2014 16:15:42 +0530
Message-ID: <CAC3mp02joXnMME8WWq0jrT5fm5SUMkJ15H_DC3Oaz=y9C_DyCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42335 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaIUKpn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 21 Sep 2014 06:45:43 -0400
Received: by mail-oa0-f51.google.com with SMTP id o6so818279oag.24
        for <linux-pwm@vger.kernel.org>; Sun, 21 Sep 2014 03:45:42 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, thierry.reding@gmail.com

Hi Thierry and all,

Many thanks in advance. My name is Naidu Tellapati. I am from India.

The Pulse Density Modulation DAC which we have on our SOC produces a
form of analogue output according to the relative density of output
pulses to the intended analogue signal amplitude. The 4 PDM outputs
are provided that can be used to control targets such as an LCD
backlight. After going through Linux PWM documentation, I understand
that our PDM DAC driver does not exactly fit into the Linux PWM
framework.

The PDM DAC block takes only input clock and a 12 bit value (as input
pulse) configured in one of the SOC configuration registers as an
input and based on some simple internal logic, the block produces a
form of analogue output according to the relative density of output
pulses to the intended analogue signal amplitude. The PDM DAC block
won't take duty_cycle as input configuration parameters. Instead it
takes 12 bit value (input pulse) as a configuration parameter.

The plan is to develop a driver which could be upstream-able to Linux
Kernel. Now could you please suggest me under which linux driver
subsytem I can place my PDM Driver.

Thanks and regards,
Naidu.
