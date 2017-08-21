From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH repost2] pwm: renesas-tpu: remove support for sh7372
Date: Mon, 21 Aug 2017 11:07:04 +0200
Message-ID: <20170821090704.GG14174@verge.net.au>
References: <20170818100858.GA15521@verge.net.au>
 <20170818152801.GA18307@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41940 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbdHUJHE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 05:07:04 -0400
Content-Disposition: inline
In-Reply-To: <20170818152801.GA18307@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Aug 18, 2017 at 05:28:01PM +0200, Thierry Reding wrote:
> On Fri, Aug 18, 2017 at 12:09:01PM +0200, Simon Horman wrote:
> > Remove support for the SH7372 (SH-Mobile AP4) from the renesas-tpu driver.
> > 
> > Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> > removes this SoC from the kernel in v4.1.
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 1 -
> >  drivers/pwm/pwm-renesas-tpu.c                             | 1 -
> >  2 files changed, 2 deletions(-)
> 
> Applied, thanks.

Thanks!
