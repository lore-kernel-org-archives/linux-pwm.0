From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v7 01/11] mfd: add atmel-hlcdc driver
Date: Mon, 6 Oct 2014 13:38:20 +0200
Message-ID: <20141006133820.4905847a@bbrezillon>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
	<1412175188-28278-2-git-send-email-boris.brezillon@free-electrons.com>
	<20141006104917.GF25202@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55071 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751407AbaJFLiY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 07:38:24 -0400
In-Reply-To: <20141006104917.GF25202@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Yao <mark.yao@rock-chips.com>

On Mon, 6 Oct 2014 12:49:17 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Oct 01, 2014 at 04:52:58PM +0200, Boris Brezillon wrote:
> [...]
> > diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> [...]
> > @@ -0,0 +1,122 @@
> > +/*
> > + * Copyright (C) 2014 Free Electrons
> > + * Copyright (C) 2014 Atmel
> > + *
> > + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published by
> > + * the Free Software Foundation.
> [...]
> > +MODULE_LICENSE("GPL");
> 
> Should be "GPL v2" according to the header comment.

I'll fix that.

> 
> Thierry



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
