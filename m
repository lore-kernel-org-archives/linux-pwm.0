Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A753E301
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180713; cv=none; b=uschAcyq5ke+JlEZLKWeSyCjhKhLT44a4uDCcPourmcV/sQ3Zh1TiY9s+x5cIpGUeSjvDUxvdykwCOe9ziuGohWvmpnSHmt5UbP4EuxDsLDiBVf/NGqXzjWzGoXKb3V5LZj6T+GFnCum2g54RCzdQhz6sqG8l0gaesW941buYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180713; c=relaxed/simple;
	bh=FnBZz2rwbEXSSYx5Rf7kopIfq4oTw76NqAv0lfIxYYw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+ZZdLniYIuIguPCHJN8CCxbOuwwiEVCuZO8jTmBD3+Db8t4hvuW7O/vIrEV46087P53W9CxHGNYtJu6ria0g6BVoVPImy5b02I2vdmm7+Ma+4ABKPZG+Wb8hrB8gu2slS+1LgbxWJ6uu00a6I5Rd1XEAZyPChyHo8ErmMFpGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PbhddKNQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PbhddKNQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so959645f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790180707; x=1790785507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uK06dRcc183p1gV2Bdi0P3JOfOANYfMBgsbGabniYGA=;
        b=PbhddKNQubPsTU15jq0xoks9b8/luKnt1AJwHEiqOLqaZ7jAQ7Mt+0QjbYeLEz0VeI
         IVu3XvQo9jbMtJxi6mFGtF8r+zKiJmoHtU0Cl9cm0L2oy76kq1YtYEhthlOA30h5wBti
         GhtmICCCiQfq7ztf5vvJcV+DKA2ubso0QJDVOlSWcpVxtv6dHaEdKWGsOGkKZm8tHn3p
         BakB9HbVWqWJ3Dwxw187YFd02H49VFHdVQJ4IKfRiXt1JqG7NNM+pb939PlMirsVka+l
         9fNOxemtxlZtfqBRZOL8UOk3ORS3h0JomqgH8mWPGW78d8BNvu0iNACqR6jB392cIeSM
         pB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180707; x=1790785507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uK06dRcc183p1gV2Bdi0P3JOfOANYfMBgsbGabniYGA=;
        b=J1cnX2LxP85rmRCct+KfR6VhBl+gGXa9OwNAzi/LF86r2SBC6mhsk4XIXfAPmSDtyn
         5HWwPIybBsxynMxcEg9tjTbS9dcRGo9EM/hR5CTinmJx0XOj7LTZPso3afkC8VlYJY3t
         I8ODDJHXAYF44aFRR118MrLI+X7so3J0rDC+av4YY8s9+94iiAwU72Wp2mc0/LZIFcD4
         k/JnPiRhfhr65rZ20SlWatGxkZJoP4tVzUbtgGPmRsioHR1YnDpim1eqSduga81fK3O5
         4HRUbiQRY5H0ko9QS9AsnojUuJ/iEu03qcd3gVtzopz6ukSKxjdgMGYo4sfcRUympP4+
         rd6A==
X-Forwarded-Encrypted: i=1; AKwUvBwNMPPu7Xgbu9OcIL6Ls9J9L+cQc4CJKPuWGzZtVtZDL4abFqUsmxZ/8Hnm+/hqtowc9QHKC+E1Wm4=@vger.kernel.org
X-Gm-Message-State: AFuF++mD/WXKbSPckCZBogCfLJ9dU9Mp793llcnOMMezqak4scTtWxWW
	7AB8ZOpfZhR9BtkvW1YdRbd3tef45NHf4r/Y4dKjejcTJBy1d4xX4jGhG35+lEFq2oU=
X-Gm-Gg: AYBFou0Eb1B1U3WyYE2r1NR3x9QQVwCmgDKMVxmhSZGCcrbtMf/DsrHB35HwT5Bz5Fw
	1gwAhEgVY60te+aqcOxRaz0F4UJxR3LY6cQb9eClM7Oi3y8xM6GCo7o2mTGRAu0ZA9SSrsxGdFx
	esKK9g1pYq7/EALSSMSoEjJteeJUZ6qYb+4lh3BEXLbHRm3G5q3yOgWAok+Clr5f1XkA8doAsBi
	1AuD1V0+HQl1iDWqU5FmmlwJD9zXZiVcj0lrM5stOHa6/3jd5x5BhKpLcno/PYgnnUoKYf3Yol7
	8OxXzL9UntEqowJFC4XAl58vPxX54mcXWqVTkzKFI4MZeXY/Wu4EYLFdHc5dzp+NY9dDZ64QQjT
	Br+/1AZ9iBNAYwBVacOjiNKW0r3IRYjvem7YhwXENwO//UaWmL6F/GLcLGjj2pMNqjXIFG83z7v
	r+u3e5ojl0IiMxCGNFW0YC+iqepQ8I066AAPpZka9jhUS2owbGQPGOv/6z3v3wiB0k5vT/LoGgp
	P007pMXCFxueWlgb+k=
X-Received: by 2002:a05:6000:491e:b0:487:7fd:734 with SMTP id ffacd0b85a97d-48867081acdmr4844345f8f.18.1790180706879;
        Wed, 23 Sep 2026 09:25:06 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c1fdsm9260151f8f.14.2026.09.23.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:25:06 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 23 Sep 2026 18:28:47 +0200
To: Gary Guo <gary@garyguo.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <arP-P_a7OyhtMQyr@apocalypse>
References: <cover.1789724999.git.andrea.porta@suse.com>
 <22f454003902173a7230d0aee5fbd7261fcc163e.1789724999.git.andrea.porta@suse.com>
 <DLM3VDAEVVEO.1STV7HI3M3YXK@garyguo.net>
 <arPLa_g4mAg1t2rq@apocalypse>
 <DLMQPQRYTSNW.2Z6C0408NMCYK@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLMQPQRYTSNW.2Z6C0408NMCYK@garyguo.net>

On 14:46 Wed 23 Sep     , Gary Guo wrote:
> On Wed Sep 23, 2026 at 1:51 PM BST, Andrea della Porta wrote:
> > Hi Gary,
> > thanks for your feedback!
> >
> > On 20:51 Tue 22 Sep     , Gary Guo wrote:
> >> On Fri Sep 18, 2026 at 10:59 AM BST, Andrea della Porta wrote:

<...snip...>

> >> > +++ b/drivers/pwm/pwm-rp1.c
> >> > +
> >> > +int rp1_pwm_read_tachometer(struct device *dev)
> >> > +{
> >> > +	struct pwm_chip *chip;
> >> > +	struct rp1_pwm *rp1;
> >> > +	u32 tach_val;
> >> > +	int ret;
> >> > +
> >> > +	if (!dev)
> >> > +		return -EINVAL;
> >> > +
> >> > +	device_lock(dev);
> >> 
> >> You should use the device link mechanism for synchronizing unbind / runtime PM.
> >> That can be done in your RP1 fan driver, and it doesn't need locking on this
> >> driver.
> >
> > This does not enforce the locking though.
> 
> What locking do you think is needed?
> 
> Driver core takes care of ordering so you will never see a depended device
> going away while a dependant device is still bound. Your RP1 fan driver just
> need to make sure that it never calls this API after it's itself unbound --
> which it needs to guarantee anyway.

I think you're referring to the struct device (data) and module binary unloading
from memory, which is guaranteed not to happen when there is a dependent device
using it, but what happens when you try to unbind or suspend the device?
More on that below...

> 
> > Is it enough to just rely on
> > caller to create the device link in advance? IOW, just add a documentation
> > comment to the exported function prologue stating that the consumer is
> > responsible to sync via a device link is acceptable?
> 
> If you use pwm_get API then a device link is automatically created for you
> already (however, this automatic link does not pass runtime PM flags, so if you
> need that you still need to add link explicitly).

This driver implements only static PM ops so I think both pwm_get API or
device_link_add should deal automatically with races.
OTOH, what if the consumer obtains a reference to the PWM device via of_* API (or
other means)? Thhose calls does not create device link and we would still have unsync
critical paths.
I'm just trying to figure out whether I should design the exported function as
foolproof and caller agnostic wrt sync issues.
If relying on the caller to use pwm_get/device_link_add is enough, I'd be happy to
find out I'm just being overly paranoid, dropping all the locking to make teh code
simpler.

> 
> How this is supposed to be synchronized or documented is very hard to get right
> without seeing the user side driver -- if you already have a working version of
> the RP1 fan driver it might benefit to have it attached as a RFC patch in the

Agreed, that's why I was trying to be as consumer agnostic as possible. After all,
coupling two modules wrt their locking requirements is usually better to be avoided.
As for the sample fan driver, I have only a simple module that grab a reference
to the pwm device and call the exported tachometer function, so nothing really useful
for this discussion, yet.

> series; or an option to to drop the tachometer API and add it as part of the fan
> driver series.

That is a great advice. I think it's beneficial to discuss everything in one place,
and as a plus we won't block the pwm driver.

> 
> > Otherwise the only way I see to protect it in any scenario is via the mutex
> > I've already implemented and a second flag for the removing path (device_lock
> > will be dropped, of course).
> >
> >> 
> >> So Sashiko is kinda reporting a false positive here.
> >> 
> >> > +
> >> > +	chip = dev_get_drvdata(dev);
> >> > +	if (!chip) {
> >> > +		ret = -ENODEV;
> >> > +		goto err_dev_unlock;
> >> > +	}
> >> > +
> >> > +	rp1 = pwmchip_get_drvdata(chip);
> >> > +	if (!rp1) {
> >> > +		ret = -ENODEV;
> >> > +		goto err_dev_unlock;
> >> > +	}
> >> > +
> >> > +	mutex_lock(&rp1->lock);
> >> > +	if (!rp1->clk_enabled) {
> >> > +		ret = -EBUSY;
> >> > +		goto err_clk_unlock;
> >> > +	}
> >> > +
> >> > +	ret = regmap_read(rp1->regmap, RP1_PWM_PHASE(2), &tach_val);
> >> > +	if (ret)
> >> > +		goto err_clk_unlock;
> >> > +
> >> > +	ret = (int)tach_val;
> >> > +
> >> > +err_clk_unlock:
> >> > +	mutex_unlock(&rp1->lock);
> >> > +err_dev_unlock:
> >> > +	device_unlock(dev);
> >> > +
> >> > +	return ret;
> >> > +}
> >> > +EXPORT_SYMBOL_NS_GPL(rp1_pwm_read_tachometer, "RP1_PWM_FAN");
> >> > +
> >> > +static int rp1_pwm_probe(struct platform_device *pdev)
> >> > +{
> >> > +	struct device *dev = &pdev->dev;
> >> > +	unsigned long clk_rate;
> >> > +	struct pwm_chip *chip;
> >> > +	void __iomem	*base;
> >> > +	struct rp1_pwm *rp1;
> >> > +	int ret;
> >> > +
> >> > +	chip = devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
> >> > +	if (IS_ERR(chip))
> >> > +		return PTR_ERR(chip);
> >> > +
> >> > +	rp1 = pwmchip_get_drvdata(chip);
> >> > +	ret = devm_mutex_init(dev, &rp1->lock);
> >> > +	if (ret)
> >> > +		return ret;
> >> > +
> >> > +	base = devm_platform_ioremap_resource(pdev, 0);
> >> > +	if (IS_ERR(base))
> >> > +		return PTR_ERR(base);
> >> > +
> >> > +	rp1->regmap = devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config);
> >> > +	if (IS_ERR(rp1->regmap))
> >> > +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize regmap\n");
> >> 
> >> You mentioned "rework regmap error paths" in cover letter.
> >> 
> >> But the issue is that regmap doesn't need be used here at all. RP1 is on PCIe
> >> so there is no need for bus abstraction, direct use of MMIO is sufficient.
> >> MMIO accessors have no error paths, so you're saying yourself from having to
> >> handle that, and also reduce the overhead by not having to go through an
> >> abstraction w/ indirect funicton calls.
> >>
> >> I suppose regmap was used when syscon was there; but it's not needed anymore.
> >
> > True, and I don't have any issue in converting back to MMIO call and drop the conditional for
> > error checking, but please consider the following, since the driver may be extended in the
> > future to support more features:
> >
> > - regmap gives you free debugfs view on the registers, which may be useful to test
> >   the new features.
> 
> Do you have any register that we want to access that is not part of the PWM
> facility, other than tachometer?

Not at the moment, no. But I don't see how this impact the debugfs usefulness.

> 
> > - regmap_write/read may still return an error in case the passed register is not in range.
> >   This will be trapped at runtime only, but could still be useful during development
> 
> I think this is rather a anti-feature. Having additional error paths for some
> thing that never happens is not a good idea, especially that you basically get 0
> coverage for these paths.

Sure. Well this is true once the code is crystallized and tested, so it's somewhat
still useful (only) during future development. But I got the point, and I agree.

> 
> You already know the shape of the register region, so the bounds checking
> provided by regmap would be better served by an ahead-of-time check:
> 
>     #define RP1_PWM_REG_MAX (RP1_PWM_DUTY(RP1_PWM_NUM_PWMS) + 4)
> 
>     struct resource *res;
>     base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>     if (IS_ERR(base))
>         return PTR_ERR(base);
> 
>     if (resource_size(res) < RP1_PWM_REG_MAX) ...

Fine for the probe method, but regmap_read/write also check for the range, for free.

> 
> Shameless plug: Rust abstractions for I/O access is actually pretty good in this
> regard in the sense that we try to prove statically that access canot fail. It
> also has PWM and platform abstractions. If you're interested in learning Rust
> this driver might be a good candidate :) If you're going to LPC we can chat
> about this there.

Now I'm tempted! :)
Although it will took far more time to upstream the driver so I think I have
to posticipate Rust for another driver.
Thanks for being so available for the LPC, really appreciated! Not sure if I
can make it this year but we'll see...

Regards,
Andrea

> 
> Best,
> Gary
> 
> > - I expect the PWM driver to be a access with very low frequency, so I guess the overhead 
> >   imposed by regmap is negligible.
> >
> > Since we already have it, I'd prefer to leave regmap if possible for the aforementioned reasons,
> > but I'm obviously open to drop it in favor of direct MMIO calls in case you or anyone else are
> > not seeing those as real benefits.
> 
> 
