From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/5] arm64: dts: r8a7795-salvator-x: Enable PWM
Date: Mon, 24 Apr 2017 11:35:55 +0300
Message-ID: <2906686.sXpvJSxI8y@avalon>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com> <2637169.nvyUM18Pqy@avalon> <CAO3366xaWH7YtktGpJ07ypzxuudyJc63PxxAeVeOi98Rann1Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:42420 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166837AbdDXIev (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Apr 2017 04:34:51 -0400
In-Reply-To: <CAO3366xaWH7YtktGpJ07ypzxuudyJc63PxxAeVeOi98Rann1Lg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>

Hi Ulrich,

On Monday 24 Apr 2017 10:22:31 Ulrich Hecht wrote:
> On Mon, Apr 24, 2017 at 9:59 AM, Laurent Pinchart wrote:
> > How about using pwm1 for backlight as done in "[PATCH v2 09/13] arm64:
> > dts: r8a7795: salvator-x: Add panel backlight support" ?
> 
> Makes sense. Simon, should that go in a separate patch, or should I
> add it to this one?

How about applying "[PATCH v2 09/13] arm64: dts: r8a7795: salvator-x: Add 
panel backlight support" and rebasing this patch to only handle pwm2 ?

-- 
Regards,

Laurent Pinchart
