From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
Date: Wed, 17 Jan 2018 15:14:19 -0800
Message-ID: <20180117231357.GC112833@google.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <20180112183512.GB102880@google.com>
 <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
 <CAHp75VcaFDEQ1cBzeU2eBj_vf19ok6EWLC07SOTQLRH8BQSbzA@mail.gmail.com>
 <9a130c0b-572d-be0b-8ac7-596714208d41@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33763 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeAQXOW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Jan 2018 18:14:22 -0500
Received: by mail-pg0-f66.google.com with SMTP id i196so12353160pgd.0
        for <linux-pwm@vger.kernel.org>; Wed, 17 Jan 2018 15:14:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9a130c0b-572d-be0b-8ac7-596714208d41@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jonathan Corbet <corbet@lwn.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

On Tue, Jan 16, 2018 at 10:24:59AM +0200, Claudiu Beznea wrote:
> Please explain me further. From this I understand, as a general rule,
> that the device tree binaries from, e.g. 3 years ago, should be
> compatible with, e.g. the current version of kernel?

Yes.

https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt
