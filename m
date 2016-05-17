From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
Date: Tue, 17 May 2016 13:04:09 +0200
Message-ID: <20160517130409.0670a94f@bbrezillon>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
	<20160517110005.GA26166@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58761 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbcEQLEL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 07:04:11 -0400
In-Reply-To: <20160517110005.GA26166@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Tue, 17 May 2016 13:00:05 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> > The PWM device exposed by the HLCDC IP is configured with an inverted
> > polarity by default. Registering the PWM chip with the normal polarity
> > was not a problem before commit 42e8992c58d4 ("pwm: Add core
> > infrastructure to allow atomic updates") because the ->set_polarity()
> > hook was called no matter the current polarity state, but this is no longer
> > the case.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic updates")  
> 
> That's not technically correct, because it's the driver that has the
> bug. The core change merely exposes it.

Agree.

> How about if I sort this into
> the pwm-atomic branch and reword the commit message accordingly? That
> way things should all stay bisectible.

As you wish.

> 
> Then again, given the breakage caused by the pwm_args patch I suppose
> it doesn't matter much because that's part of a stable branch that I
> can't rebase.

Yep, I know :-(.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
