Date: Tue, 10 Sep 2013 18:54:46 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v2] pwm: pxa: add device tree support to pwm driver
Message-ID: <20130910165445.GA22111@ulmo>
References: <1378751420-19227-1-git-send-email-mikedunn@newsguy.com>
 <522E3B5B.90406@wwwdotorg.org>
 <522F40A3.9030701@newsguy.com>
 <522F4CF9.3070601@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <522F4CF9.3070601@wwwdotorg.org>
List-ID: <linux-pwm.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2013 at 10:46:49AM -0600, Stephen Warren wrote:
> On 09/10/2013 09:54 AM, Mike Dunn wrote:
> > On 09/09/2013 02:19 PM, Stephen Warren wrote:
> >> On 09/09/2013 12:30 PM, Mike Dunn wrote:
[...]
> >>> +- reg: physical base address and length of the registers used by the=
 pwm channel
> >>> +  NB: One device instance must be created for each pwm that is used,=
 so the
> >>> +  length covers only the register window for one pwm output, not tha=
t of the
> >>> +  entire pwm controller.  Currently length is 0x10 for all supported=
 devices.
> >>> +- #pwm-cells: should be 3.
> >>> +   cell 1: the per-chip index of the PWM to use,
> >>
> >> That cell shouldn't be needed if you really want to have one DT node p=
er
> >> PWM channel.
> >=20
> > Yes, but I was afraid to deviate from the format used by the other PWM
> > controllers.  (But in that case, it should at least be documented as "m=
ust be
> > zero". Thanks.)  If going my owm way is acceptable, I'll define my own
> > of_xlate() parser and remove this cell.
>=20
> I don't think there's any issue with deviating; that's exactly what
> #pwm-cells is for.

Agreed, I have no objections to using a custom .of_xlate().

Thierry

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSL07VAAoJEN0jrNd/PrOhM8MP/A/+6TvKJr4NsAI6a2n7oB4j
TIqfsiVbCmG2nmDP1nMurPmrKv6jOV1u0ex563YUUD6x5Wlvt8ovjahwDEq/Y7dx
r9ts7DQh7CezerITxCro89qWEsWID4hCy6MEsn5eJSNWtEJ/z34JGQqQPJ8rNbO6
9vJw8ajnwje8wxE28LeZQSs5x8P/BfOOqKgyPOrY9WkfAhZhzV3ckX+Yk4HkKRjd
vZ6RdXJMt3zKDs0e1nucuELpYdC2RJUMQkKif962NrEISUzS5y2abgrsn8Q+xAdo
mjTvmK3O32RO3oM1vFLYzmA9nNYAzR0tFq+heM1W30rqiZuDQiXXYo7qrljJCvR2
mq2xZMjbJpSpfrYb7EMikOjgb58XVw/DIPt/VsN3KjIWbxDCvGxwl5lWHsuUH2yN
NjwF3rwzHiG3rbRdVEuNMcSKiTaWiyhfKWw9EkEEtt7lwsUUBZ+KSeU+oFg5wYOx
3aQJ7Dg+QAtM+Odzr46fIDeXBQktRJMLk10+7MECoDlEobp/y5xetPDGiwFc/qiq
7elSpIJg4W8TYoF+0pUTOkExvHqaEndcWOcqg68EKT48T7wOA+nLvnVHutIMs7i3
a+pmuWA2eFeRnoa/c40lWiZ64ccgSQyi6TtghAcZ9QAcUqCQrHqnrMnGduMy5e8K
P11oN/irDcCiTBC1nFti
=JCNF
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
