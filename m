From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/12] gpio: Only descend into gpio directory when
 CONFIG_GPIOLIB is set
Date: Tue, 14 Jun 2016 08:58:49 +0200
Message-ID: <CACRpkdaEkCzp3W4x3HSurpHb1qtkJp-SvWCAQivuL3x8CBY-iQ@mail.gmail.com>
References: <20160613200211.14790-1-afd@ti.com> <20160613200211.14790-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35053 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbcFNG6u (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jun 2016 02:58:50 -0400
Received: by mail-oi0-f43.google.com with SMTP id w5so163741912oib.2
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jun 2016 23:58:50 -0700 (PDT)
In-Reply-To: <20160613200211.14790-2-afd@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Rusty Russell <rusty@rustcorp.com.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, lguest@lists.ozlabs.org, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, linux-me

On Mon, Jun 13, 2016 at 10:02 PM, Andrew F. Davis <afd@ti.com> wrote:

> When CONFIG_GPIOLIB is not set make will still descend into the gpio
> directory but nothing will be built. This produces unneeded build
> artifacts and messages in addition to slowing the build. Fix this here.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Patch applied. Strange that this went unnoticed for years.

Yours,
Linus Walleij
