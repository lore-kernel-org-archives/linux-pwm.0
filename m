From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 02/11] pwm: sysfs: Add PWM Capture support
Date: Tue, 12 Apr 2016 12:15:50 +0200
Message-ID: <20160412101550.GB18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456932729-9667-3-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pwm@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 03:32:00PM +0000, Lee Jones wrote:
> Allow a user to read PWM Capture results from /sysfs. First,
> the user must tell PWM Capture which channel they wish to
> read from:
>=20
>   $ echo 2 > $PWMCHIP/capture
>=20
> To start a capture and read the result, simply read the file:
>=20
>   $ cat $PWMCHIP/capture
>=20
> The output format is left to the device.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 9c90886..3572ef4 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -23,6 +23,8 @@
>  #include <linux/kdev_t.h>
>  #include <linux/pwm.h>
> =20
> +static int capture_channel;

Can't do that, this is very racy because it isn't protected by any lock.
Fortunately I don't think the global variable is at all necessary. See
below.

> +
>  struct pwm_export {
>  	struct device child;
>  	struct pwm_device *pwm;
> @@ -167,16 +169,42 @@ static ssize_t polarity_store(struct device *child,
>  	return ret ? : size;
>  }
> =20
> +static ssize_t capture_show(struct device *child,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pwm_device *pwm =3D child_to_pwm_device(child);
> +
> +	return pwm_capture(pwm, capture_channel, buf);
> +}
> +
> +static ssize_t capture_store(struct device *child,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t size)
> +{
> +	int val, ret;
> +
> +	ret =3D kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	capture_channel =3D val;
> +
> +	return size;
> +}
> +
>  static DEVICE_ATTR_RW(period);
>  static DEVICE_ATTR_RW(duty_cycle);
>  static DEVICE_ATTR_RW(enable);
>  static DEVICE_ATTR_RW(polarity);
> +static DEVICE_ATTR_RW(capture);

These are all per-PWM attributes and the specific PWM device that they
are associated with can be retrieved using child_to_pwm_device(child)
(see the other attributes' implementation for examples). So I don't
think the capture attribute needs to be writable at all. You already
implement capture_show() in almost the right way, and if you drop the
channel parameter from pwm_capture() as I suggested in my reply to patch
1/11 this should resolve itself automatically.

Of course capture_show() would become slightly more beefy if we return a
standard result structure rather than leave it up to the drivers to fill
out the sysfs string. The good thing is that it will be common code and
therefore the sysfs interface would return the same format regardless of
the driver.

Perhaps something like

	struct pwm_device *pwm =3D child_to_pwm_device(child);
	struct pwm_capture result;

	err =3D pwm_capture(pwm, &result);
	if (err < 0)
		return err;

	return sprintf(buf, "%u %u\n", result.duty_cycle, result.period);
=09
would work?

Thierry

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDMrWAAoJEN0jrNd/PrOhd1sP/2prP/I7HyzcNFoYXtRzEpQ6
xPklBuExFi6EmTI+uXjR88KvtoE2SK2cNpfMPaBvWG3rhlWa9BRcLYzjTXY6mNe7
3PzqjSo1BAXyHzEkEYYM5UhFitFlLSYXkTNhlDEte9Z0Rl748MHn2YzHnV4yuBoG
kha8XRSBfJGTIh+cafRTf0Nidyy/xnV1g8SlSoU3pcJENDPArO3MclV//CYd742I
pmJ/r90SraIohxxbIJuQrH+SOvjUKU5RnD+yuNctwFp6JKwgg4dMpOAWSvWwG7DA
pgerByE0ReM3LhuB2avLTeZY/uiyfn4wsV7KaLR2ac70RaCidH5VUqa1UDFO8wNj
jpg0tuj6xq1fesFEP5abCFBi+WGCALm5s10myhOAMvoVHNaobVuVpkESFfxC1Vdx
4KQVsQDEBfc7u/99aBpFZLNBiNRw6X1zq8vs7NA5ZEP2fOtL6+bxPlPsmdFA11hU
DcBj3ck3LaJQcPommhklda5OLb3RJ4hMa8ZodcvVsJM55UVx31t/Fu3aOgyIg5xB
6whdoveewClIamD4S7TYrRyINV/ZO3JlQ3jRJt0pdbYA0bt5p+xwuLHsHClP+VXJ
x4X+sTUF1seXhhkHRkq8h3ZNyWgFttDT4Ah15x4Rw30UeGU/r7fWPLXUNApjN8cF
ogsHvNptWvmNVvMI9VsF
=aC66
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
