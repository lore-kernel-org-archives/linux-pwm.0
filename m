From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 0/5] Add capture functionality to OMAP pwm driver
Date: Mon, 8 Jan 2018 22:57:18 +0100
Message-ID: <20180108215718.GA17091@lenoch>
References: <20180108153926.GA3916@lenoch>
 <20180108215123.GU3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:47558 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756458AbeAHV5V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jan 2018 16:57:21 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992404AbeAHV5Tgop3B (ORCPT <rfc822;linux-pwm@vger.kernel.org>
        + 1 other); Mon, 8 Jan 2018 22:57:19 +0100
Content-Disposition: inline
In-Reply-To: <20180108215123.GU3875@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Keerthy <j-keerthy@ti.com>, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com

On Mon, Jan 08, 2018 at 01:51:23PM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [180108 15:42]:
> > Tony, I wanted to do something easy to understand as a base for
> > event capture interrupt, but either I do not understand hardware,
> > or it indeed cannot do pulse capture.
> 
> Hmm OK. Presumably it works as it's been around for a long time,
> I thought any edge trigger will just sample the current counter
> value and that's it..

Yes, indeed, _any_ edge will just sample the current counter value.
So what can hardware say about duty cycle of this signal?
  +-+        +-+
__| |________| |___

Depending time capture was started it will either trigger on first
falling or first rising edge.


	ladis
