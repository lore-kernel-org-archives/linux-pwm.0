From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] drivers: pwm: core: implement pwm dead-times
Date: Sun, 28 May 2017 01:28:45 +0300
Message-ID: <CAHp75Ve=v=50UmpOyi1guY3NVuk41U0Ma+_P__5NK7_dNr6gZg@mail.gmail.com>
References: <1494317990-9131-1-git-send-email-claudiu.beznea@microchip.com> <1494317990-9131-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35294 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdE0W2q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 May 2017 18:28:46 -0400
In-Reply-To: <1494317990-9131-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Linux Documentation List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, nicolas.ferre@microchip.com

On Tue, May 9, 2017 at 11:19 AM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Extends PWM framework to support PWM dead-times.
> The notions introduced are rising edge dead-time
> and falling edge dead-time. These are useful for
> PWM controllers with channels that have more than
> one outputs.
> The implementation add sysfs interface for
> configuration. It extends the pwm_state structure
> with two new members which keeps the values for
> dead-times.
> There were no additions in device tree for PWM channels
> initialized by device tree.

AFAIU it's effectively called phase of the signal.
It looks to me much simpler if you allow to have linked / virtual
channels instead of creating a lot of (duplicated) properties.

-- 
With Best Regards,
Andy Shevchenko
