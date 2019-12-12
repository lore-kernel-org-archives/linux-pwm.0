From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
Date: Thu, 12 Dec 2019 13:07:28 -0600
Message-ID: <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
 <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com> <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 12, 2019 at 2:16 AM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
> On 12/11/19 8:52 PM, Rob Herring wrote:
> > On Wed, Dec 11, 2019 at 9:00 AM Benjamin Gaignard
> > <benjamin.gaignard@st.com> wrote:
> >> Typical pwm nodes should be named pwm@xxx.
> >> The pattern shouldn't match nodes named pwm-xxx to avoid
> >> conflicts with pinmux or pwm-fan nodes.
> > It only matches pwm-$(a-hex-number), not any string, so that shouldn't
> > be a problem. This is needed for things like GPIO based devices (not
> > just PWMs) which don't have any address.
> >
> > Pinmux nodes are going to need to adopt some sort of standard pattern
> > we can match on.
> I have push a patch to stop using '@' and '_' in pinmux groups names:
> https://lore.kernel.org/patchwork/patch/1162591/
> It remove the warnings when compiling the devicetre with W=12 but pwm.yaml
> complain because pwm pinmux is named pwm-1.
>
> How can I solve these issues at the same time ?

Name the nodes *-pins or *-pins-[0-9]. You're probably going to need
some pattern anyways when you do a pinmux schema.

Rob
