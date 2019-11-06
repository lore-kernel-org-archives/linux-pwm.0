From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Date: Wed, 6 Nov 2019 17:35:20 -0600
Message-ID: <CAL_Jsq+b_e1MbXx6918+iKfrTgqoozxOZ2rEYgogChZDWR_+iQ@mail.gmail.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com> <20191103110841.3ad3ecfb@archlinux>
 <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
 <20191106040657.GA5294@bogus> <d0196570-9140-c775-742c-89092056e651@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d0196570-9140-c775-742c-89092056e651@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Alexandre TORGUE <alexandre.torgue@st.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Fabrice GASNIER <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormrepl>
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 6, 2019 at 1:52 PM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
> On 11/6/19 5:06 AM, Rob Herring wrote:
> > On Tue, Nov 05, 2019 at 11:07:16AM +0100, Benjamin Gaignard wrote:
> >> Le dim. 3 nov. 2019 =C3=A0 12:08, Jonathan Cameron <jic23@kernel.org> =
a =C3=A9crit :
> >>> On Thu, 31 Oct 2019 13:30:38 +0100
> >>> Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> >>>
> >>>> Convert the STM32 IIO trigger binding to DT schema format using json=
-schema
> >>>>
> >>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >>> I'm far from great on these as still haven't taken the time I should =
to learn
> >>> the yaml syntax properly.  A few comments inline however based mostly=
 on this
> >>> doesn't quite look like other ones I've seen recently.
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan
> >>>
> >>>> ---
> >>>>   .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++=
++++++++++++
> >>>>   .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ----------=
--
> >>>>   2 files changed, 44 insertions(+), 25 deletions(-)
> >>>>   create mode 100644 Documentation/devicetree/bindings/iio/timer/st,=
stm32-timer-trigger.yaml
> >>>>   delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm=
32-timer-trigger.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-ti=
mer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-tim=
er-trigger.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..1c8c8b55e8cd
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-tri=
gger.yaml
> >>>> @@ -0,0 +1,44 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger=
.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: STMicroelectronics STM32 Timers IIO timer bindings
> >>>> +
> >>>> +maintainers:
> >>>> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> >>>> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> >>>> +
> >>>> +properties:
> >>>> +  $nodemane:
> >>> nodename?
> >> That will be in v2
> > No, $nodename is correct. The '$' signifies something we generate and
> > add in. IOW, not a real property. I guess we could have used 'name' her=
e
> > and stuck with traditional OpenFirmware.
> let's go for $name

No, $nodename is correct. You don't have a choice. That is what the
tooling generates.

Rob
