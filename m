From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 01/11] pwm: Add PWM Capture support
Date: Tue, 12 Apr 2016 12:08:45 +0200
Message-ID: <20160412100845.GA18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37049 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbcDLKIt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Apr 2016 06:08:49 -0400
Content-Disposition: inline
In-Reply-To: <1456932729-9667-2-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 03:31:59PM +0000, Lee Jones wrote:
> Supply a PWM Capture call-back Op in order to pass back
> information obtained by running analysis on PWM a signal.
> This would normally (at least during testing) be called from
> the Sysfs routines with a view to printing out PWM Capture
> data which has been encoded into a string.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/core.c  | 26 ++++++++++++++++++++++++++
>  include/linux/pwm.h | 13 +++++++++++++
>  2 files changed, 39 insertions(+)

Overall I like the concept of introducing this capture functionality.

However I have a couple of questions, see below.

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index d24ca5f..8f4a8a9 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -494,6 +494,32 @@ unlock:
>  EXPORT_SYMBOL_GPL(pwm_set_polarity);
> =20
>  /**
> + * pwm_capture() - capture and report a PWM signal
> + * @pwm: PWM device
> + * @channel: PWM capture channel to use
> + * @buf: buffer to place output message into
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int pwm_capture(struct pwm_device *pwm, int channel, char *buf)

This public interface seems to be targetted specifically at sysfs. As
such I'm not sure if there is reason to make it public, since the code
is unlikely to ever be called by other users in the kernel.

Do you think it would be possible to make the interface more generic by
passing back some form of structure containing the capture result? That
way users within the kernel could use the result without having to go
and parse a string filled in by the driver. It would also be easy to
implement sysfs support on top of that. Another advantage is that there
would be a standard result structure rather than a free-form string
filled by drivers that can't be controlled.

What kind of result does the STi hardware return? Looking at the driver
later in the series it seems to support triggering interrupts on rising
and falling edges and capture some running counter at these events. If
the frequency of the counter increment is known, these numbers should
allow us to determine both the period and duty cycle of the PWM signal
in nanoseconds. Would it be possible to rewrite this function and the
driver patch to something like this:

	int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result);

Where

	struct pwm_capture {
		unsigned int period;
		unsigned int duty_cycle;
	};

?

Another thing I noticed is that the code here seems to be confusing
channels and devices. In the PWM subsystem a struct pwm_device
represents a single channel. Allowing the channel to be specified is
redundant at best, and confusing at worst.

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDMkpAAoJEN0jrNd/PrOhAHgP/2SCyBt28J+9KQkYRo/Vi6u3
j1mk1c91cmgDnR5IuMfd0x9BI7a+BYtFk5aLuncTrpJJ5tOQe2uG6E2R6i/nF9/Z
jmAcoK2YSNI6fuOUAPtD3P0Bq7VFVNro2kegZ2OxofMBzRKFJMNc7hLWZinVDrfH
qvJMP/t/r0qmDCbTv2mLcUj6pzIDmGV8iF9EG4rHLzYq0y9uvaW4UtXFjdBNcqwM
J5KqoxEnphoWtP+TlGD43EWAZgu6JEK7viU/V5sT4VJhkXyzNvtQJyLJSm+MfGZm
nGfNJ2BeIIVmGXtVsas7x991AEAY3n81wXkAuni76TdciLOsDBpccfqLPKNCqQIJ
Y+6IGyaB7HctaCXT6R2XGI2n3+cj4+KSFmV4VYKGhY7lGSICkLnzWTjqM3adzQ0S
M7quxz4KOCnXXB655zFQzaMzuC/m7G6M1A24H2gS+ipMz9oPKyugRRammUKyCpAW
kH42KbghxZyB2EVoCdWLO4fHcjegM4hgkZ/RLZh0uTiL/f55NjSmq5Ry7l+41Skj
ZL/4uyN8Eepeg4cx6marr8H8nZwITbTi5N/uvT1FVFX43f+FIgkygkQEG92BkJOi
DQ6ODsur2aSv+ZuTRfkN01y2lFiq0qw7b8o/pbEM9DZdbZtZwO8iGML699PjMEp4
vGLfVfwWHekzXHbJveVT
=Xhr8
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
