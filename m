From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Sat, 1 Mar 2014 12:40:08 +0100
Message-ID: <201403011240.09137.arnd@arndb.de>
References: <1393342067-9086-1-git-send-email-shc_work@mail.ru> <20140226160046.GD29659@e106331-lin.cambridge.arm.com> <20140301100641.cdb4398a4172700cfd318213@mail.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:55188 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbaCALkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Mar 2014 06:40:22 -0500
In-Reply-To: <20140301100641.cdb4398a4172700cfd318213@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Saturday 01 March 2014, Alexander Shiyan wrote:
> I want to elaborate on the current CLPS711X lineup:
> PS7110  - EOL October 30, 2001
> PS7111  - EOL October 30, 2001
> EP7209  - EOL April 25, 2003
> EP7211  - EOL April 25, 2003
> EP7212  - EOL April 25, 2003
> CS89712 - EOL August 15, 2005
> EP7309  - Production
> EP7311  - Production
> EP7312  - Production

Thanks for the list. I wonder if there is a good place to keep this in the
kernel source for reference.

> So at the moment, and long enough, produced only three models of CPUs.
> I am sure that the hardware with old CPUs will not be able to use the
> new kernel due to memory limitations, low CPU frequency, etc.
> 
> My suggestion is to always use a compatibility string for platform entirely,
> ie "cirrus,clps711x-$UNIT", otherwise it may result in misleading.

From your list, it's pretty clear that there won't be any new chips named
PS711x for x > 1, so using that string is not ambiguous. That is good
to know. It's also the oldest chip in the family, so naming things after that
is consistent.

> In any case, I would like to hear the final decision on this issue,
> since there are several drivers already using this scheme and some drivers
> awaiting applying into the kernel.
> I do not insist on its position, but just want to clarify to make changes
> to existing drivers and use the approved compatibility string in the future.
> At the current stage, these changes will not lead to anything terrible.

How about we keep using the cirrus,clps711x as the string that drivers
match against, but change the DT representation to always list the specific
model in addition? That way we are prepared to handle quirks if we need to,
but you don't have to change the binding in incompatible ways.

This means you should list e.g.

	compatible = "cirrus,ep7309-pwm", "cirrus,clps711x-pwm";

or 

	compatible = "cirrus,clps7110-pwm", "cirrus,clps711x-pwm";

depending on the model. For units that were introduced in a later
model, I would recommend to use the first model that had it rather
than the original clps711x that didn't, like

	compatible = "cirrus,ep7311-kitchensink", "cirrus-ep7211-kitchensink";

For bindings that are already reviewed and merged, I wouldn't change
them any more even if they inaccurately list clps711x for units that
were not present in clps7111, but for new ones I'd prefer to follow
the common practice to your best knowledge.

	Arnd
