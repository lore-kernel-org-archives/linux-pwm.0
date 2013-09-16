Return-Path: <swarren@wwwdotorg.org>
Message-ID: <52375FDB.8090405@wwwdotorg.org>
Date: Mon, 16 Sep 2013 13:45:31 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PWM: PXA: add device tree support to PWM driver
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com> <201309151607.04244.marex@denx.de> <523718D3.4050003@newsguy.com> <201309161710.15800.marex@denx.de>
In-Reply-To: <201309161710.15800.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>

On 09/16/2013 09:10 AM, Marek Vasut wrote:
...
> OK, to push it ad-absurdum, shall we not start listing every single revision of 
> the CPU as well? Like pxa250a0 250a1 etc ? Yes , this many-to-one mapping is 

It's not about CPU revisions, it's about revisions of the SoC that
contain the IP block.

> something I don't quite understand, that's why I'd love to see a good reasoning 
> from Stephen.

Please see the earlier discussions.
