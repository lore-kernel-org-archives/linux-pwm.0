Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1310113.outbound.protection.outlook.com ([40.107.131.113]:51554
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfCMHBw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 13 Mar 2019 03:01:52 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 13 Mar 2019 07:01:46 +0000
Message-ID: <TY2PR01MB4812E6489E20BCE94AC29E38D84A0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190312124532.GO31026@ulmo>
In-Reply-To: <20190312124532.GO31026@ulmo>
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>

Hi Thierry,

> From: Thierry Reding, Sent: Tuesday, March 12, 2019 9:46 PM
> On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
<snip>
> > @@ -368,10 +370,12 @@ int pwmchip_remove(struct pwm_chip *chip)
> >
> >  	free_pwms(chip);
> >
> > -	pwmchip_sysfs_unexport(chip);
> > -
> >  out:
> >  	mutex_unlock(&pwm_lock);
> > +
> > +	if (!ret)
> > +		pwmchip_sysfs_unexport(chip);
> > +
>=20
> I don't exactly remember why he sysfs unexport happens this late. It's
> completely asymmetric to what we do in pwmchip_add_with_polarity() and
> commit 0733424c9ba9 ("pwm: Unexport children before chip removal") is
> a strong indication that this was wrong to begin with. Maybe we should
> just move pwmchip_sysfs_unexport() where it belongs, which is right
> after pwmchip_sysfs_unexport_children(). In that case, we probably do
> not need separate functions anymore either.

I think so. So, I'll merge them on v2 patch.

> We also really want to remove sysfs irrespective of whether or not the
> chip will be removed as a result of pwmchip_remove(). We can only assume
> that the driver will be gone after that, so we shouldn't leave any
> dangling sysfs files around.

I think so.

> Yoshihiro, does it work if you move pwmchip_sysfs_unexport() to the top
> of pwmchip_remove(), right below pwmchip_sysfs_unexport_children(),
> instead? Does that get rid of the lockdep warning as well? That way it
> is also outside of the pwm_lock section, which indeed doesn't seem to be
> needed.

It works. That gets rid of the lockdep warning as well. So, I'll submit v2
patch later.

> Moving the pwmchip_sysfs_export() call outside of that section also
> seems fine and it'd be perfectly symmetric with pwmchip_remove() again.

I think so.

Best regards,
Yoshihiro Shimoda

> Thierry
