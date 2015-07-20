From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 06/15] pwm: define a new pwm_state struct
Date: Mon, 20 Jul 2015 10:04:59 +0200
Message-ID: <20150720080458.GG29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 10:21:52AM +0200, Boris Brezillon wrote:
[...]
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
[...]
> +struct pwm_state {
> +	unsigned int		period; 	/* in nanoseconds */
> +	unsigned int		duty_cycle;	/* in nanoseconds */
> +	enum pwm_polarity	polarity;
> +};

No need for the extra padding here.

Thierry

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKuqAAoJEN0jrNd/PrOh6RoP/jMn6xBFA2ku9RO+1pD3rh20
W3BQf6Of5EhRGubqYtI6q1tWdXKigLjDn9/X/30NfbNO0eg+lmVk4IVJ3HISj6+y
DoOGhfphS5yN72WZzUZB8n3Ec9QWafuVDD+vxtO2ykrQTxQpZ2PH8u8/lJ3mHAgA
vok0732x2fv1tv8+PeY/lENDrtH5LJb14ib2HWIX/zB/Ua3FV1rnbueJKRpMGBcp
MuzdfRYCJM2P0WGOe5Lmlz0nSRURkbPtc7o4tC+6apcPvQqI7JTwox9gLZ2aBNxb
tdqdaLEKr4Z8FY6WSqyP0KDTxRWO+G6OUBYax+WwzJ74YrJxFvYWwZNZ6FnE+6jh
tmszg+XKaC9vwp4kk2qWfMc6EFuIiv4FgdLUtc0K9bHIyyhckr/kwLJNdSUUn0XI
OzKk/2w8WZDjAP/1FJL6d/EihXwDBGE5wQx/gVu7oqhoKtnx6zEoao1Stri9KxjA
gvuirzrGTXPQ/cTsteslgsQRZlqapRRBUyuS/9bC/5VIOqfvNwy6Rh3uRXF+2i7i
kJ4jQNtlX7U2eX6WRicf9jni1VkSkEWQ97tlR25JHr0xih/JWYF9iUKjikOjhRjn
Cn2XqeR9Le9Qs/rtuYvwQcBTYVCQiPbs7W7bkprcHROXOOIQte9SCi+ikFkOZ/ZJ
3bZVbvJx0yFPRwSwEJ2b
=bKNV
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
