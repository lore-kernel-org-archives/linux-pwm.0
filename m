From: "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
Subject: RE: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Date: Wed, 20 May 2020 10:49:17 +0000
Message-ID: <SN6PR11MB257539FDB99C0CA5A9668A84F6B60@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200518141842.GA3594@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:55375 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKtW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 May 2020 06:49:22 -0400
In-Reply-To: <20200518141842.GA3594@bogus>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "Wan Mohamad, Wan Ahmad Zainie" <wan.ahmad.zainie.wan.mohamad@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, May 18, 2020 10:19 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: devicetree@vger.kernel.org; u.kleine-koenig@pengutronix.de; Wan
> Mohamad, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> robh+dt@kernel.org; linux-pwm@vger.kernel.org; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; thierry.reding@gmail.com
> Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Inte=
l
> Keem Bay PWM
>=20
> On Sun, 17 May 2020 21:52:40 +0800,  wrote:
> > From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> >
> > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> >
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39
> ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> >
>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> Error: Documentation/devicetree/bindings/pwm/pwm-
> keembay.example.dts:22.31-32 syntax error FATAL ERROR: Unable to parse
> input tree
> scripts/Makefile.lib:312: recipe for target
> 'Documentation/devicetree/bindings/pwm/pwm-keembay.example.dt.yaml'
> failed
> make[1]: *** [Documentation/devicetree/bindings/pwm/pwm-
> keembay.example.dt.yaml] Error 1
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>=20
> See https://patchwork.ozlabs.org/patch/1292157
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure dt-schema is up to date:
>=20
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master -=
-
> upgrade
>=20
> Please check and re-submit.

Thank you for reviewing. Will check this again and make sure it passes befo=
re submitting v2.
