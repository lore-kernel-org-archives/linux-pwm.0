From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: salvator-common: add 12V regulator to
 backlight
Date: Thu, 21 Sep 2017 10:04:46 +0200
Message-ID: <20170921080445.GA15749@verge.net.au>
References: <1505750174-29888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdXOVSUK3q0ZMZXU9CjAWNN37tkK0DUC9CQtFTq8AqMecw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60686 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdIUIFV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Sep 2017 04:05:21 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXOVSUK3q0ZMZXU9CjAWNN37tkK0DUC9CQtFTq8AqMecw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Sep 20, 2017 at 01:55:09PM +0200, Geert Uytterhoeven wrote:
> On Mon, Sep 18, 2017 at 5:56 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > This fixes the warning "pwm-backlight backlight: backlight supply power
> > not found, using dummy regulator".
> >
> > Fixes: b33be33670217533 ("arm64: dts: salvator-x: Add panel backlight support")
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied as a fix for v4.14.
