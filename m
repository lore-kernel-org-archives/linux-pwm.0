From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [RESEND PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
Date: Thu, 23 May 2019 11:09:33 +0200
Message-ID: <CA+M3ks5O9YpZ-4f3x=bFn_LxJu+6i3pu7jsWv_93pe14y8V71w@mail.gmail.com>
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com> <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Loic PALLARDY <loic.pallardy@st.com>, tduszyns@gmail.com, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, u.kleine-koenig@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Le ven. 10 mai 2019 =C3=A0 09:51, Fabrice Gasnier <fabrice.gasnier@st.com> =
a =C3=A9crit :
>
> On 4/18/19 11:37 AM, Fabrice Gasnier wrote:
> > This patch series adds power management support for STM32 LP Timer:
> > - PWM driver
> > - Document the pinctrl states for sleep mode
> >
> > It also adds device link between the PWM consumer and the PWM provider.
> > This allows proper sequencing for suspend/resume (e.g. user will likely
> > do a pwm_disable() before the PWM provider suspend executes), see [1].
> >
> > [1] https://lkml.org/lkml/2019/2/5/770
> >
>
> Hi Thierry,
>
> Please let me know if you have some more comments on this series. It's
> been under review since quite some time now.
>

Hi Thierry,

Does something is blocking on this series ?
How can we progress on it ?

Regards,
Benjamin

> Thanks in advance,
> Best Regards,
> Fabrice
>
> > ---
> > resend v5:
> > - update collected acks
> >
> > Changes in v5:
> > - improve a warning message, fix a style issue.
> >
> > Changes in v4:
> > - improve error handling when adding the PWM consumer device link.
> >
> > Changes in v3:
> > - Move the device_link_add() call to of_pwm_get() as discussed with Uwe=
.
> >
> > Changes in v2:
> > - Don't disable PWM channel in PWM provider: rather refuse to suspend
> >   and report an error as suggested by Uwe and Thierry.
> > - Add patch 3/3 to propose device link addition.
> > - No updates for STM32 LP Timer IIO driver. Patches can be send separat=
ely.
> >
> > Fabrice Gasnier (3):
> >   dt-bindings: pwm-stm32-lp: document pinctrl sleep state
> >   pwm: stm32-lp: Add power management support
> >   pwm: core: add consumer device link
> >
> >  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
> >  drivers/pwm/core.c                                 | 50 ++++++++++++++=
++++++--
> >  drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
> >  include/linux/pwm.h                                |  6 ++-
> >  4 files changed, 82 insertions(+), 8 deletions(-)
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
