Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:46911
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfE3KNX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 30 May 2019 06:13:23 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 30 May 2019 10:12:39 +0000
Message-ID: <OSAPR01MB308953DA7219D38BDD25A712D8180@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559116082-9851-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190529133817.GB17223@ulmo>
In-Reply-To: <20190529133817.GB17223@ulmo>
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH 3/4] pwm: sysfs: Add suspend/resume support
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Thierry,

> From: Thierry Reding, Sent: Wednesday, May 29, 2019 10:38 PM
>=20
> On Wed, May 29, 2019 at 04:48:01PM +0900, Yoshihiro Shimoda wrote:
> > According to the Documentation/pwm.txt, all PWM consumers should have
> > power management. Since this sysfs interface is one of consumers so tha=
t
> > this patch adds suspend/resume support.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pwm/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 7eb4a13..72dafdd 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -18,6 +18,7 @@ struct pwm_export {
> >  	struct device child;
> >  	struct pwm_device *pwm;
> >  	struct mutex lock;
> > +	bool enabled_in_suspend;
>=20
> How about if we save the complete state here? Something like:
>=20
> 	struct pwm_state suspend;
>=20
> Or similar? Then we can just pwm_get_state() into that and then disable
> the PWM like you do.

I got it. I'll fix it on v2.

> >  };
> >
> >  static struct pwm_export *child_to_pwm_export(struct device *child)
> > @@ -372,10 +373,73 @@ static struct attribute *pwm_chip_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(pwm_chip);
> >
> > +static int pwm_class_suspend_resume(struct device *parent, bool suspen=
d)
>=20
> I would prefer if these were separate functions. I think the kind of
> conditionals that you have below isn't worth the few lines that you may
> save by fusing suspend/resume into one function.
>=20
> Also, if you store struct pwm_state suspend during suspend, then both
> implementations will end up being fairly different, so reusing the code
> isn't going to be much of an advantage.

I got it. As you said, separate functions are better for the code readabili=
ty.

> > +{
> > +	struct pwm_chip *chip =3D dev_get_drvdata(parent);
> > +	unsigned int i;
> > +	int ret =3D 0;
> > +
> > +	for (i =3D 0; i < chip->npwm; i++) {
> > +		struct pwm_device *pwm =3D &chip->pwms[i];
> > +		struct device *child;
> > +		struct pwm_export *export;
> > +		struct pwm_state state;
> > +
> > +		if (!test_bit(PWMF_EXPORTED, &pwm->flags))
> > +			continue;
> > +
> > +		child =3D device_find_child(parent, pwm, pwm_unexport_match);
> > +		if (!child)
> > +			goto rollback;
> > +
> > +		export =3D child_to_pwm_export(child);
> > +		put_device(child);	/* for device_find_child() */
> > +		if (!export)
> > +			goto rollback;
>=20
> Con this even happen? I have a hard time seeing how.

Oops! This condition is unnecessary. I'll remove it.

> > +
> > +		mutex_lock(&export->lock);
> > +		pwm_get_state(pwm, &state);
>=20
> All of the above is shared code, so perhaps it'd be worth putting that
> into a separate helper function to achieve the code reuse that you
> otherwise get from sharing the function.

I got it. I'll make such a helper function on v2.

> > +		if (suspend) {
> > +			if (state.enabled)
> > +				export->enabled_in_suspend =3D true;
> > +			state.enabled =3D false;
> > +		} else if (export->enabled_in_suspend) {
> > +			state.enabled =3D true;
> > +			export->enabled_in_suspend =3D false;
> > +		}
>=20
> This in particular is what I mean. I think the two levels of
> conditionals here make this more complicated to understand than
> necessary.

I think so.

> > +		ret =3D pwm_apply_state(pwm, &state);
> > +		mutex_unlock(&export->lock);
> > +		if (ret < 0)
> > +			goto rollback;
> > +	}
> > +
> > +	return ret;
> > +
> > +rollback:
> > +	/* roll back only when suspend */
> > +	if (suspend)
> > +		pwm_class_suspend_resume(parent, false);
>=20
> And then there's stuff like this where you need to explain what's going
> on just to save a couple of lines of code.

I'll add a comment on v2.

> Other than that, looks really nice.

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> Thierry
>=20
> > +
> > +	return ret;
> > +}
> > +
> > +static int pwm_class_suspend(struct device *parent)
> > +{
> > +	return pwm_class_suspend_resume(parent, true);
> > +}
> > +
> > +static int pwm_class_resume(struct device *parent)
> > +{
> > +	return pwm_class_suspend_resume(parent, false);
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_clas=
s_resume);
> > +
> >  static struct class pwm_class =3D {
> >  	.name =3D "pwm",
> >  	.owner =3D THIS_MODULE,
> >  	.dev_groups =3D pwm_chip_groups,
> > +	.pm =3D &pwm_class_pm_ops,
> >  };
> >
> >  static int pwmchip_sysfs_match(struct device *parent, const void *data=
)
> > --
> > 2.7.4
> >
