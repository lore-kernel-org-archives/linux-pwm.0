From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] ARM: dts: r8a7740: Correct TPU register block size
Date: Thu, 21 Dec 2017 10:32:02 +0100
Message-ID: <20171221093201.53kvbftn5qwxcpgf@verge.net.au>
References: <1513699327-27357-1-git-send-email-geert+renesas@glider.be>
 <1513699327-27357-2-git-send-email-geert+renesas@glider.be>
 <20171220082306.zdtntqbajyy666zv@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46968 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdLUJcJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Dec 2017 04:32:09 -0500
Content-Disposition: inline
In-Reply-To: <20171220082306.zdtntqbajyy666zv@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Dec 20, 2017 at 09:23:07AM +0100, Simon Horman wrote:
> On Tue, Dec 19, 2017 at 05:02:05PM +0100, Geert Uytterhoeven wrote:
> > The Timer Pulse Unit has registers that lie outside the declared
> > register block.  Enlarge the register block size to fix this.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This was probably based on the old platform code, which also assumed a
> > register block size of 0x100.
> 
> Reviewed-by: Simon Horman <simon.horman@netronome.com>
> 
> With reference to "User's Manual: Hardware" v2.00.

... and applied for v4.16.
