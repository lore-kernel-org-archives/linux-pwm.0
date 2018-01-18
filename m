From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
Date: Thu, 18 Jan 2018 11:11:16 +0200
Message-ID: <b928d56f-8eb6-c23e-99bd-c4089e80f923@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <20180112183512.GB102880@google.com>
 <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
 <CAHp75VcaFDEQ1cBzeU2eBj_vf19ok6EWLC07SOTQLRH8BQSbzA@mail.gmail.com>
 <9a130c0b-572d-be0b-8ac7-596714208d41@microchip.com>
 <20180117231357.GC112833@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:17074 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeARJLV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jan 2018 04:11:21 -0500
In-Reply-To: <20180117231357.GC112833@google.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jonathan Corbet <corbet@lwn.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree <devicetree@vger.kern>



On 18.01.2018 01:14, Brian Norris wrote:
> On Tue, Jan 16, 2018 at 10:24:59AM +0200, Claudiu Beznea wrote:
>> Please explain me further. From this I understand, as a general rule,
>> that the device tree binaries from, e.g. 3 years ago, should be
>> compatible with, e.g. the current version of kernel?
> 
> Yes.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt
> 
I agree, I found that after some research.

Thanks,
Claudiu
