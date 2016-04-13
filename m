From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 02/11] pwm: sysfs: Add PWM Capture support
Date: Wed, 13 Apr 2016 10:40:50 +0100
Message-ID: <20160413094050.GO8094@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-3-git-send-email-lee.jones@linaro.org>
 <20160412101550.GB18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36706 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965747AbcDMJkz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2016 05:40:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id v188so163991491wme.1
        for <linux-pwm@vger.kernel.org>; Wed, 13 Apr 2016 02:40:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160412101550.GB18882@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 02, 2016 at 03:32:00PM +0000, Lee Jones wrote:
> > Allow a user to read PWM Capture results from /sysfs. First,
> > the user must tell PWM Capture which channel they wish to
> > read from:
> >=20
> >   $ echo 2 > $PWMCHIP/capture
> >=20
> > To start a capture and read the result, simply read the file:
> >=20
> >   $ cat $PWMCHIP/capture
> >=20
> > The output format is left to the device.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/sysfs.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >=20
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 9c90886..3572ef4 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/kdev_t.h>
> >  #include <linux/pwm.h>
> > =20
> > +static int capture_channel;
>=20
> Can't do that, this is very racy because it isn't protected by any lo=
ck.
> Fortunately I don't think the global variable is at all necessary. Se=
e
> below.
>=20
> > +
> >  struct pwm_export {
> >  	struct device child;
> >  	struct pwm_device *pwm;
> > @@ -167,16 +169,42 @@ static ssize_t polarity_store(struct device *=
child,
> >  	return ret ? : size;
> >  }
> > =20
> > +static ssize_t capture_show(struct device *child,
> > +			    struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	struct pwm_device *pwm =3D child_to_pwm_device(child);
> > +
> > +	return pwm_capture(pwm, capture_channel, buf);
> > +}
> > +
> > +static ssize_t capture_store(struct device *child,
> > +			     struct device_attribute *attr,
> > +			     const char *buf, size_t size)
> > +{
> > +	int val, ret;
> > +
> > +	ret =3D kstrtoint(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	capture_channel =3D val;
> > +
> > +	return size;
> > +}
> > +
> >  static DEVICE_ATTR_RW(period);
> >  static DEVICE_ATTR_RW(duty_cycle);
> >  static DEVICE_ATTR_RW(enable);
> >  static DEVICE_ATTR_RW(polarity);
> > +static DEVICE_ATTR_RW(capture);
>=20
> These are all per-PWM attributes and the specific PWM device that the=
y
> are associated with can be retrieved using child_to_pwm_device(child)
> (see the other attributes' implementation for examples). So I don't
> think the capture attribute needs to be writable at all. You already
> implement capture_show() in almost the right way, and if you drop the
> channel parameter from pwm_capture() as I suggested in my reply to pa=
tch
> 1/11 this should resolve itself automatically.
>=20
> Of course capture_show() would become slightly more beefy if we retur=
n a
> standard result structure rather than leave it up to the drivers to f=
ill
> out the sysfs string. The good thing is that it will be common code a=
nd
> therefore the sysfs interface would return the same format regardless=
 of
> the driver.
>=20
> Perhaps something like
>=20
> 	struct pwm_device *pwm =3D child_to_pwm_device(child);
> 	struct pwm_capture result;
>=20
> 	err =3D pwm_capture(pwm, &result);
> 	if (err < 0)
> 		return err;
>=20
> 	return sprintf(buf, "%u %u\n", result.duty_cycle, result.period);
> =09
> would work?

Same reply as 1/11.  Now I know that we should be treating each of our
channels, as *completely* separate devices, I think this method seems
reasonable.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
