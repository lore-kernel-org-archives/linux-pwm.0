From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/8] r8a7795/6 Salvator-X PWM enablement
Date: Fri, 28 Apr 2017 09:29:21 +0200
Message-ID: <20170428072921.GE10196@verge.net.au>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46561 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164786AbdD1H31 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Apr 2017 03:29:27 -0400
Content-Disposition: inline
In-Reply-To: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@glider.be, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com

On Thu, Apr 27, 2017 at 04:37:35PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> Here's the revised series enabling PWMs on r8a7795 and r8a7796 Salvator-X
> boards.
> 
> This revision addresses the issues found by Geert and adds Laurent's
> backlight support patch, including a version for r8a7796.
> 
> CU
> Uli
> 
> Changes since v1:
> - PWM clock is S0D12, not S3D4
> - dts: fix register lengths, add resets
> - only enable one set of pins for each PWM
> - add backlight support
> 
> 
> Laurent Pinchart (1):
>   arm64: dts: r8a7795: salvator-x: Add panel backlight support
> 
> Ryo Kodama (2):
>   clk: renesas: r8a7796: add PWM clock
>   arm64: dts: r8a7796-salvator-x: Add PWM device support
> 
> Takeshi Kihara (3):
>   pinctrl: sh-pfc: r8a7796: Add PWM pins, groups and functions
>   arm64: dts: r8a7796: Add PWM device nodes
>   arm64: dts: r8a7795-salvator-x: Enable PWM2
> 
> Ulrich Hecht (2):
>   arm64: dts: r8a7796: salvator-x: Add panel backlight support
>   dt-bindings: pwm: Add R-Car M3-W device tree bindings

Hi,

am I correct in thinking that the dts patches do not cause a regression and
their only DT dependency is on the "renesas,pwm-r8a7796" compat string.
If so I am of a mind to quire them up as the nodes that need the new compat
string also make use of the "renesas,pwm-rcar" compat string which is
already present in mainline.
