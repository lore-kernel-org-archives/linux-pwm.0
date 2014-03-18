From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Documentation: dt: Add Kona PWM binding
Date: Tue, 18 Mar 2014 22:18:07 +0100
Message-ID: <20140318211806.GG5917@mithrandir>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <1394655346-30048-2-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394655346-30048-2-git-send-email-tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Doc List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 01:15:42PM -0700, Tim Kryger wrote:
> Add the binding description for the Kona PWM controller found on Broadcom=
's
> mobile SoCs.
>=20
> Signed-off-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Alex Elder <elder-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/bcm-kona-pwm.txt       | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt b/Doc=
umentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
> new file mode 100644
> index 0000000..c8e2d13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
> @@ -0,0 +1,24 @@
> +Broadcom Kona PWM controller device tree bindings
> +
> +This controller has 6 channels.
> +
> +Required Properties :
> +- compatible: should be "brcm,kona-pwm"

This is somewhat inconsistent because the example below clearly doesn't
set the compatible property to "brcm,kona-pwm". Perhaps better wording
would be:

	- compatible: should contain "brcm,kona-pwm"

> +- reg: physical base address and length of the controller's registers
> +- clocks: phandle + clock specifier pair for the external clock
> +- #pwm-cells: should be 3.  The first cell specifies the per-chip index
> +  of the PWM to use, the second cell is the period in nanoseconds, and
> +  the third cell is the flags.

Please use the canonical description for this:

	- #pwm-cells: Should be 3. See pwm.txt in this directory for a
	  description of the cells format.

> +Refer to pwm/pwm.txt for generic pwm controller node properties.

With the above, this line should go away. But still: "pwm controller" ->
"PWM controller".

Thierry

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKLgOAAoJEN0jrNd/PrOhdPoP/in+sozoaEIa6Cdl51/NuIzl
WAN+rlNjkkwyUVm4XY87guwwdnu0scjX0Cal8PaRoxmxdFSMNcRS5AX2W8pCylZo
9Te4RkFDnLJaXaYlcpvhevRz014HmY1tGnWdaSxySPt2jUXP3Y/d1rLZAVX9kOh6
BpBxER71Jd6htT8BkM2OSMdCHUPDxy48WLbtiyb2zngsrChqEa4OOHQf9YRKFdQD
SYWvQqP6gAeBTYH8amtTQjCf+4JAphlCm29ZaaMYsncbbiVKm24NXNFDTYXA8hcz
U7su5nwwHJOFhGGdsTX+wQ/9WHItewIsqIMnysdaRAU4xZ6E00N8tSoAIrKtA6HP
nvV5pWgpEaIDR1VKck38sNa6g1PKFJ1hDx1dHAjvKOKUxHiN8Yt4YdgAs7/NDhYP
7xtaYS0bCukAZrQxyo6CL7rASuy45TkRC4KyIZ29IeHrW+tHXpFfT8rAI0HUTVVm
8MxUAGyiuY+23wtSmqL9tI4l8LXvmXUk4xREYF1T9G+bQNrYvONczaY8gDNgybqc
ga22mMCnqH7Yo0vu0Vi/eZDw1JKu3728NSGfkCAwxPi0lsbybQ03dJJMoYkYGG6K
yfSDN1t2ei2RNmGXf81onNm5L5lU15lDvuERAc61c7/+VYk880l6gphOL1m+BiaR
1CKE+TDQGKAv0aY/wBxt
=z6zP
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
