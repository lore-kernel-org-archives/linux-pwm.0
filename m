From: "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
Subject: RE: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem Bay
Date: Fri, 5 Jun 2020 13:49:02 +0000
Message-ID: <SN6PR11MB257550F64750773C039956ECF6860@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200523210525.5ciw3lyafbwr26qn@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43354 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgFENtG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 5 Jun 2020 09:49:06 -0400
In-Reply-To: <20200523210525.5ciw3lyafbwr26qn@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Wan Mohamad, Wan Ahmad Zainie" <wan.ahmad.zainie.wan.mohamad@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>


> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-owner@vger.kernel.org>
> On Behalf Of Uwe Kleine-K=F6nig
> Sent: Sunday, May 24, 2020 5:05 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem=
 Bay
>=20
> On Sun, May 17, 2020 at 09:52:38PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
> > In Keem Bay, the number of repetitions for the period/waveform can be
> > configured from userspace. This requires addition of a sysfs attribute
> > to get/set the repetition count. Setting this value to 0 will result
> > in continuous repetition of the waveform until the channel is disabled
> > or reconfigured.
>=20
> There is nothing specific for Keem Bay in this patch, the only special th=
ing here is
> that this driver is the first implementor.
>=20
> IMHO all drivers that don't support count should be changed to fail if a =
count > 0
> is passed and introducing support in the sysfs interface should be a sepa=
rate
> change.
>=20
> Having said that I'm not convinced this is a good idea given that only ve=
ry few
> driver can support this interface. Also this needs documentation, e.g. wh=
at is
> expected from .get_state().
>=20
> You should also motivate what this functionality is used for in the commi=
t log
> and I'd prefer to see an in-tree user (apart from sysfs which I don't cou=
nt as
> such).
>=20

Agreed, the wording used here is not accurate as this is not specific for K=
eem Bay.
Before submitting v2, I will cross-check about the use-case for this functi=
onality, and if it=20
can be implemented in some other less intrusive way to the framework (perha=
ps via a DT property?)

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
