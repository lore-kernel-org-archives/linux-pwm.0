From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 2/5] drivers: pwm: bcm-kona: Dont set polarity in probe
Date: Fri, 12 Jun 2015 11:46:21 +0200
Message-ID: <20150612094605.GD19400@ulmo.nvidia.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
 <1432670900-27687-3-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432670900-27687-3-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Arun Ramamurthy <arunrama@broadcom.com>
List-Id: linux-pwm@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 01:08:17PM -0700, Jonathan Richardson wrote:
> From: Arun Ramamurthy <arunrama@broadcom.com>
>=20
> Omit setting the polarity to normal during probe and instead use the
> new pwmchip_add_inversed function to register a PWM chip with default
> polarity of inversed for all channels as this is the actual hardware
> default.
>=20
> Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Tim Kryger <tim.kryger@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, after adapting to the pwmchip_add_with_polarity() API, thanks.

Thierry

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVeqpdAAoJEN0jrNd/PrOhBscP/19o74KuB9Tvc7VlIwOnJPBj
sgZp36d9HDCiq/WHam7icUo7ceoZhjG62Q+Ntcwo+VhwvqIcoqNMhTKQoX/kF0cE
rFvi2/wMm9QW2HVwEeylQQme+KbWxZUAmrUZ79D1LMNPjQ/Ujt6WLfN44xD9gYTp
MNcSLbR1sp4vJQmxswSMFzIRgsBcBDxrIsYlfrVbEj+sll/LD9NgLvJXEEsgs2iX
bQFL1niJ9M6tDOpNatoe+eUYQFg27hFWcrreIEUYfhygdkwz2yPUB87gA2KZu5jp
4oj3+j0nFIu6ZC8VlNDUUeOass9WG8tss1xbZvo+kSq1ZgmPLLh3ov6QSSDX7Htc
PkB9SgyJb21NTCABRJgTc3HD3LuYQyjwcwLMWxGb1AgvGDnzvSOLpF/i/BBNAMy6
pOzcvFAAPg4WM422fpge5CTHx0VmXX6w/lqxuNB7hwKbA3L8YrJjksEPWtrBwyXU
uxHYNoO4zRzLfRNHG8N24CmqpzNpVhTlbEYYtYDsKNsv8i8RoGvcnevxQ1q6ZcKT
d5IAXXdDfG+DBWHxPqkfZ5/BDg+1gRzH6mYCDuTVIv2iJbx6k67oOvirf7Auluo+
egwf7vEU1Hg8yIIYo/M06R2GQQOtwkHFfi23rSc93e7gGD+oMokr7EACagduHjlp
ESfS0y/eSilUPc+oZjKg
=e78+
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
