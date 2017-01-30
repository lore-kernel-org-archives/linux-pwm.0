From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/3] pwm/core: Try to get the module from
	pwm_get
Date: Mon, 30 Jan 2017 09:17:13 +0100
Message-ID: <20170130081713.GM3585@ulmo.ba.sec>
References: <20170122161409.21601-1-hdegoede@redhat.com>
 <20170122161409.21601-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1713990742=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170122161409.21601-3-hdegoede@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--===============1713990742==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fNagykWcDoSVAmSd"
Content-Disposition: inline


--fNagykWcDoSVAmSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2017 at 05:14:08PM +0100, Hans de Goede wrote:
> Add a module_name string to the pwm_lookup struct and if specified
> and pwmchip_find_by_name() does not find the pwmchip try calling
> request_module with the specified name.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/core.c  |  4 ++++
>  include/linux/pwm.h | 11 +++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 0d3ef29..c418a7a 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -823,6 +823,10 @@ struct pwm_device *pwm_get(struct device *dev, const=
 char *con_id)
>  		return ERR_PTR(-ENODEV);
> =20
>  	chip =3D pwmchip_find_by_name(chosen->provider);
> +	if (!chip && chosen->module_name) {
> +		request_module(chosen->module_name);

How about checking for an error code here? It's kind of pointless to try
again if the module didn't load in the first place. No need to respin, I
can make that change as I apply.

Thierry

--fNagykWcDoSVAmSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO9oUACgkQ3SOs138+
s6GC2Q/+M0JoS/1f4bDub2Z1gJr1hxR6OJS2p1skArMXvVa4JvdYurWiPNY8BPpv
SHqTlvj8IPC+1l9sL7huBnVFn1VYQntXj/Jjk98BMRasOV8iSvqLVk97lDtuGEdY
sqfPxvSTBMSXUgWRfGjMBvTXI76Qe4ArcTM9jGerN8OlYEMyg1BPuJL2RQklL/PF
JRhNvV9Z+4Ne603rNCu9lWUyCPFOblEXb5+9amJpH3z1Wii+X7Htg3XkvMYPopCB
6m8AGc0I5qB6eWPbALPMrjG22lpCoR0iLDlGUxuMg7Q81wThmnyDgyxQc/cPdm+8
EtbF9y+Kr/WUtVYtrO4Uxx+MRP8a6W8DKhEDtKZVFh+Vvevz7npmL/CGJ8m4CNNR
6cjoxvhc4Iio9c9vBDkcm7vk8FZlw+gb6Oy/IgUw+MWl9tfxCnEEL0JOCCxy4W1X
bWEjIWqKvxhefUBXWTYcmquT1R3qzm7Nyu9rqR+2zqxWSMR8rscNkORHGzEWaD+6
IkD/toNDLOTe0kUA85IIpuX1pJd0OUT8OecYSUWdn4PlNWyNX8OtCwQqoMGhJ3EV
s5v9fJZ/KK0HOPfoyHtnoSoybbdCxBkRiG8U3IadpEoHe7qVZxN8tvJ+JEBy1/gT
VID2naFYyO7Dz00pZvAzeWHI+pderX6ip+6CuO5o0fS7kdKFOy0=
=n3cr
-----END PGP SIGNATURE-----

--fNagykWcDoSVAmSd--

--===============1713990742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1713990742==--
