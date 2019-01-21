From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Date: Mon, 21 Jan 2019 17:11:05 -0600
Message-ID: <20190121231105.GA928@bogus>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
 <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, bcm-kernel-feedback-list@broadcom.com, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 15, 2019 at 04:14:21PM -0800, Scott Branden wrote:
> Hi Uwe,
> =

> On 2019-01-12 7:05 a.m., Uwe Kleine-K=F6nig wrote:
> > Hello Scott,
> > =

> > On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
> > > On 2019-01-11 12:48 p.m., Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> > > > > From: Praveen Kumar B <praveen.b@broadcom.com>
> > > > > =

> > > > > Add new compatible string for new version of pwm-kona
> > > > > =

> > > > > Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> > > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > > Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> > > > > ---
> > > > >    Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > =

> > > > > diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.=
txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > index 8eae9fe..d37f697 100644
> > > > > --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
> > > > >    This controller has 6 channels.
> > > > >    Required Properties :
> > > > > -- compatible: should contain "brcm,kona-pwm"
> > > > > +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v=
2"
> > > > Is v2 used on a newer generation of kona SoCs? On i.MX these varian=
ts
> > > > are usually named after the first SoC that came with the new varian=
t. Is
> > > > this sensible here, too?
> > > It doesn't make as much sense here as different revs of the IP block =
are
> > > picked up based on various decisions.
> > > =

> > > A new SoC could decide to use an old version.
> > IMHO this is no reason to not use the name of the oldest SoC with this
> > variant. I don't know how the SoC names are in the broadcom family, but
> > if they were (in order of age, oldest first):
> > =

> > 	ant
> > 	bear
> > 	crocodile
> > =

> > and ant and crocodile use the same IP block we would have
> > =

> > a) with v1, v2:
> > =

> > 	ant:
> > 		compatible =3D "brcm,kona-pwm-v1";
> > 	bear:
> > 		compatible =3D "brcm,kona-pwm-v2";
> > 	crocodile:
> > 		compatible =3D "brcm,kona-pwm-v1";

Version numbers can be fine, but generally only as fallbacks as even the =

same IP version can be integrated into an SoC differently.

The other issue with versions is they should be meanful such as =

corresponding to version tags in IP repos. Often, I'd guess anything =

with a 'v1' is just what some s/w person made up. Of course, we only =

can really know that for opensource IP or programmable logic IP.

If you do use versions, document what the versioning scheme is.

> > =

> > ; and
> > =

> > b) with the SoC naming:
> > =

> > 	ant:
> > 		compatible =3D "brcm,kona-ant-pwm";
> > 	bear:
> > 		compatible =3D "brcm,kona-bear-pwm";
> > 	crocodile:
> > 		compatible =3D "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";

This is the recommended practice.

> > =

> > (If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
> > defensive.)

Generally, you should have "brcm,kona-crocodile-pwm" in case there's =

some difference found later. Then you can support the bug or feature =

without a DT change.

> > =

> > I like b) (with "...-crocodile-...") better than a). crocodile using
> > "...-ant-..." is not more ugly than crocodile using "...-v1". This is
> > also a tad more robust because if broadcom releases kona-dolphin and
> > someone finds a minor difference between the IPs used on ant and
> > crocodile it depends on the order of these events who gets v3, while
> > with the SoC naming the result is clear.
> > =

> > (OK, and given that "brcm,kona-pwm" is already fixed, both approaches
> > need slight adaption, but I guess you still get what I meant.)
> =

> Thanks for your thoughts and explanation.
> =

> It is unfortunate devicetree has no proper guidelines or documentation on
> =

> binding naming.=A0 In the interest of getting this upstream we can name it

Surely we've captured that somewhere...

> =

> "brcm, omega-pwm".=A0 We can drop kona from the binding name as that
> architecture
> =

> is really no more - only IP derived from it is - hence the name kona-v2
> previously.
> =

> > =

> > Best regards
> > Uwe
> > =

> > =

> Cheers,
> Scott
