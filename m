From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [RFC 5/5] pwm: pwm-omap-dmtimer: Add capture functionality
Date: Mon, 8 Jan 2018 23:06:02 +0100
Message-ID: <20180108220602.GA17615@lenoch>
References: <20180108153926.GA3916@lenoch>
 <20180108154336.GE4077@lenoch>
 <20180108215931.GV3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:48498 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeAHWGE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jan 2018 17:06:04 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992956AbeAHWGDECQZB (ORCPT <rfc822;linux-pwm@vger.kernel.org>
        + 1 other); Mon, 8 Jan 2018 23:06:03 +0100
Content-Disposition: inline
In-Reply-To: <20180108215931.GV3875@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com

On Mon, Jan 08, 2018 at 01:59:31PM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [180108 15:46]:
> > Here it seems hardware can capture both edges, but I do not see a way
> > how to tell it I want start from either low to high or high to low
> > transition. Clues?
> 
> At least dm3730 TRM documents TCM bits [9:8] for TCLR, but you
> probably know that already..
> 
> If you're having hard time getting things starting, maybe something
> like this helps:
> 
> stop timer in TCLR register
> configure timer in TCLR
> write some value to TLDR, maybe 0?
> set ST bit in TCLR to start

Let me clarify it a bit more. I have no problem starting timer and capture
events. I just didn't find a way how to tell hardware I want to start
with for example rising edge, so rising edge goes to TCAR1 and failing edge
to TCAR2. Substracting those gives pulse width.

	ladis
