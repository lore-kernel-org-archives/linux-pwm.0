From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 5/5] pwm: pwm-omap-dmtimer: Add capture functionality
Date: Mon, 8 Jan 2018 13:59:31 -0800
Message-ID: <20180108215931.GV3875@atomide.com>
References: <20180108153926.GA3916@lenoch>
 <20180108154336.GE4077@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:39814 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756311AbeAHV7f (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 8 Jan 2018 16:59:35 -0500
Content-Disposition: inline
In-Reply-To: <20180108154336.GE4077@lenoch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keerthy <j-keerthy@ti.com>, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com

* Ladislav Michl <ladis@linux-mips.org> [180108 15:46]:
> Here it seems hardware can capture both edges, but I do not see a way
> how to tell it I want start from either low to high or high to low
> transition. Clues?

At least dm3730 TRM documents TCM bits [9:8] for TCLR, but you
probably know that already..

If you're having hard time getting things starting, maybe something
like this helps:

stop timer in TCLR register
configure timer in TCLR
write some value to TLDR, maybe 0?
set ST bit in TCLR to start

Regards,

Tony
