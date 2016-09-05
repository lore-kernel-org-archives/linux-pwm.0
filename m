From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: Create device class for pwm channels
Date: Mon, 5 Sep 2016 17:20:25 +0200
Message-ID: <20160905152025.GT31424@ulmo.ba.sec>
References: <1468880090-46076-1-git-send-email-davidhsu@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wiiWofWi8Et/oezL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468880090-46076-1-git-send-email-davidhsu@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hsu <davidhsu@google.com>
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--wiiWofWi8Et/oezL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 03:14:50PM -0700, David Hsu wrote:
> Pwm channels don't send uevents when exported, this change adds the
> channels to a pwm class and set their device type to pwm_channel so
> uevents are sent.
>=20
> To do this properly, the device names need to change to uniquely
> identify a channel.  This change is from pwmN to pwmchipM:N
>=20
> Signed-off-by: David Hsu <davidhsu@google.com>
> ---
> v2: Use parent name instead of chip->base for channel naming.
>=20
>  Documentation/pwm.txt |  6 ++++--
>  drivers/pwm/sysfs.c   | 18 +++++++++++++-----
>  2 files changed, 17 insertions(+), 7 deletions(-)

Forgot to mention one other thing that had come to my mind...

> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
[...]
> @@ -248,9 +254,11 @@ static int pwm_export_child(struct device *parent, s=
truct pwm_device *pwm)
> =20
>  	export->child.release =3D pwm_export_release;
>  	export->child.parent =3D parent;
> +	export->child.type =3D &pwm_channel_type;
>  	export->child.devt =3D MKDEV(0, 0);
> +	export->child.class =3D &pwm_class;
>  	export->child.groups =3D pwm_groups;
> -	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> +	dev_set_name(&export->child, "%s:%u", dev_name(parent), pwm->hwpwm);

Using the colon as separator could possibly prevent the use of these
files in paths lists. Consider the case where somebody wanted to give a
list of PWM sysfs references:

	PWM_DEVICES=3D/sys/class/pwm/pwmchip0:0:/sys/class/pwm/pwmchip0:1

which might get parsed as four entries:

	- /sys/class/pwm/pwmchip0
	- 0
	- /sys/class/pwm/pwmchip0
	- 1

none of which point to a valid PWM. There are a couple of other
separators that might be possible, such as '-' or '.'.

Then again, looking at existing usage in sysfs it seems like the colon
is a fairly popular separator, so maybe I'm just being too paranoid.

Thierry

--wiiWofWi8Et/oezL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzY04AAoJEN0jrNd/PrOh6XsP/iQOfkfUyw+wGMpRL+x+fPJW
iUFO/3pAb6dRS/GRTPmqrPFnWBetEQZ+gRlZqaP8ru06bBvMRjiFMm5wO9lP8hUV
u+A/p+5Y/msmVTmOmvT0IdtLXDJTvzzIGlau5tcNjjWLMgPVO51hTsBE976OF0pO
XJ0UrJLegQTHYfjtGKhBN8ZJABPm1alinr46AKx1mAwm5nfjId4cry2/9YxeFv8L
/0KlfNP8glQZbRRjdxoHxBaSKqjouZurA/1RCcRnZQS0rdFtvNa0v7XVXdgYxo9a
aDICzWAF/qdZvDiTjzFgzT2R+E2OSQ+596FQslyLKQzJrwBgwLtkkD+dZwZ6hNru
H5AdbL5XMrFgEoHjXBcBxIewnjnxJeQ00rNJHQljMg5ZpykbSca3vJlrGfGGgtE4
Umk/XfhoJcr81FJRl1mrPpiZOiDqMvv2y1edzLKzk1veJCeYni9o/+gHV+TNDf9v
wfdOB2hVehFB4XC+eYFVpv1ivIwJGu6Z0RMHh3N870v3fpiammPQ1hiIqpsr8G7z
eA2gVl2CaChxvaUjk62qAKZcarmNuWzR7V5eZXlVN9WTNe3i2D8dJAnmX5ZMnZlH
I/SkK0jiXBNQSZuSTLVDgJDbOd5pxpFHc8PIiX0OhDg/0edGfFgm7FJ1ZhuIQeHG
7VnnFtvGpIHdqEbJBkXq
=NNX5
-----END PGP SIGNATURE-----

--wiiWofWi8Et/oezL--
