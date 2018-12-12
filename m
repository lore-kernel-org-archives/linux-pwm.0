From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Date: Wed, 12 Dec 2018 12:07:23 +0100
Message-ID: <CAJiuCccG+NtaDF70_4bJwgBCKAKxiE8379h=6qkN8OAQ8rjKBA@mail.gmail.com>
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107093613.26734-2-peron.clem@gmail.com>
 <20181212110446.GF17654@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212110446.GF17654@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Suji Velupillai <suji.velupillai@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On Wed, 12 Dec 2018 at 12:04, Thierry Reding <thierry.reding@gmail.com> wro=
te:
>
> On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Suji Velupillai <suji.velupillai@broadcom.com>
> >
> > When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> > return false, this prevents the backlight being turn on at boot time.
> >
> > Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
>
> I see v2 and v3 of patch 1 of the series. Did you work on v2 of this
> patch (2/2) as well? I don't see it on the list and it didn't seem like
> everyone was happy with this version.

No, I dropped it.

Was working on an atomic convert of the driver but I don't have access
to my cygnus board anymore.

Regards,
Clement

>
> Thierry
