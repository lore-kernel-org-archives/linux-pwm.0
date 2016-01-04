From: Alban <albeu@free.fr>
Subject: Re: [PATCH] pwm: Fix of_pwm_get() for consistent return values
Date: Mon, 4 Jan 2016 14:51:57 +0100
Message-ID: <20160104145157.25f67d67@tock>
References: <1448803057-8572-1-git-send-email-albeu@free.fr>
	<20160104081028.GA23749@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:59369 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbcADNwN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jan 2016 08:52:13 -0500
In-Reply-To: <20160104081028.GA23749@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Aban Bedel <albeu@free.fr>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 4 Jan 2016 09:10:28 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Sun, Nov 29, 2015 at 02:17:37PM +0100, Alban Bedel wrote:
> > When of_pwm_get() is called without connection ID it returns
> > -ENOENT when the 'pwms' property doesn't exists or is an empty
> > entry. However when a connection ID is given and the 'pwm-names'
> > property doesn't exists or doesn't contains the requested name it
> > returns -ENODATA or -EINVAL.
> > 
> > To get a consistent return value with both code paths we must return
> > -ENOENT when of_property_match_string() fails.
> 
> I'm not sure I understand the need for a consistent return value here.
> These are all different error conditions and the only reasonable thing
> to do here is propagate the error code from the of_*() parsing routine
> that is being called.

The problem is with optional named PWM, they will not return a clean
-ENOENT like with no name. It mean you need a different error handling
with and without name, that's error prone and unexpected. For example
that mean:

	err = pwm_get(dev, NULL);
	if (IS_ERR(err) && PTR_ERR(err) != -ENOENT)
		return PTR_ERR(err);

need to move to:

	err = pwm_get(dev, "CLK");
	if (IS_ERR(err) && PTR_ERR(err) != -ENODATA &&
			   PTR_ERR(err) != -EINVAL)
		return err;

To be somewhat equivalent, but not really. Beside the inconsistence I
also find it problematic because of the -EINVAL. It is returned because
of_pwm_get() itself pass a broken argument to
of_parse_phandle_with_args(), not the caller of of_pwm_get().

TBH I first found and fixed this error in the reset controller
framework, I later checked all users of of_property_match_string() for
similar error and found the PWM and clock subsystem to be lacking. It
sure is not essential as there is probably few, or no users of optional
PWM. However as code often get copy-pasted I think it is still
important to have a correct pattern everywhere.

Alban
