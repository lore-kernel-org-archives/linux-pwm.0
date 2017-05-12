From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/8] r8a7795/6 Salvator-X PWM enablement
Date: Fri, 12 May 2017 13:00:34 +0300
Message-ID: <4398514.qBghdda7X5@avalon>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com> <20170512091636.GG27979@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:36470 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757629AbdELKAd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2017 06:00:33 -0400
In-Reply-To: <20170512091636.GG27979@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, geert@glider.be, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com

Hi Simon,

On Friday 12 May 2017 11:16:39 Simon Horman wrote:
> On Thu, Apr 27, 2017 at 04:37:35PM +0200, Ulrich Hecht wrote:
> > Hi!
> > 
> > Here's the revised series enabling PWMs on r8a7795 and r8a7796 Salvator-X
> > boards.
> > 
> > This revision addresses the issues found by Geert and adds Laurent's
> > backlight support patch, including a version for r8a7796.
> > 
> > CU
> > Uli
> > 
> > Changes since v1:
> > - PWM clock is S0D12, not S3D4
> > - dts: fix register lengths, add resets
> > - only enable one set of pins for each PWM
> > - add backlight support
> > 
> > Laurent Pinchart (1):
> >   arm64: dts: r8a7795: salvator-x: Add panel backlight support
> > 
> > Ryo Kodama (2):
> >   clk: renesas: r8a7796: add PWM clock
> >   arm64: dts: r8a7796-salvator-x: Add PWM device support
> > 
> > Takeshi Kihara (3):
> >   pinctrl: sh-pfc: r8a7796: Add PWM pins, groups and functions
> >   arm64: dts: r8a7796: Add PWM device nodes
> >   arm64: dts: r8a7795-salvator-x: Enable PWM2
> 
> I did not notice any regressions on salvator-x/r8a7796 after applying up
> the dts patches without the clk and pinctrl patches. So I have queued up
> the dts patches as follows:
> 
> * arm64: dts: r8a7796: Add PWM device nodes
>   -> applied
> 
> * arm64: dts: r8a7795: salvator-x: Add panel backlight support
> * arm64: dts: r8a7795-salvator-x: Enable PWM2

I've asked Ulrich for a clarification on this patch as I'm not sure it's 
needed, but he hasn't answered yet. Could we delay merging it until the 
situation is clarified ?

All other patches in this series should be fine.

>   -> applied to salvator-x.dtsi instead of r8a7796-salvator-x.dts
> 
> * arm64: dts: r8a7796: salvator-x: Add panel backlight support
> * arm64: dts: r8a7796-salvator-x: Add PWM device support
>   -> not applied as they would be the same changes as those above
>      applied to salvator-x.dtsi
> 
> > Ulrich Hecht (2):
> >   arm64: dts: r8a7796: salvator-x: Add panel backlight support
> >   dt-bindings: pwm: Add R-Car M3-W device tree bindings
> 
> I took the liberty of reposting the dt-bindings patch with an updated To/Cc
> list.
> 
> >  .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
> >  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  34 +++++
> >  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  35 +++++
> >  arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  70 ++++++++++
> >  drivers/clk/renesas/r8a7796-cpg-mssr.c             |   1 +
> >  drivers/pinctrl/sh-pfc/pfc-r8a7796.c               | 153 ++++++++++++++++
> >  6 files changed, 294 insertions(+)

-- 
Regards,

Laurent Pinchart
