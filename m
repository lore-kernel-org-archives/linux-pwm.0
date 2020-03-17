From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Date: Tue, 17 Mar 2020 16:06:42 +0200
Message-ID: <CAGgjyvEye0nEwyUpjTxVV2ftvF+QUibLBdiT3ZSsX6M4PQSW0g@mail.gmail.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-4-oleksandr.suvorov@toradex.com> <20200317133638.5951a743@ub1910>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317133638.5951a743@ub1910>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Barker <pbarker@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 3:37 PM Paul Barker <pbarker@konsulko.com> wrote:
>
> On Tue, 17 Mar 2020 14:32:27 +0200
> Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:
>
> > PWM can have a normal polarity and a reverted one. The reverted polarity
> > value is defined.
> > Define the PWM_POLARITY_NORMAL to be used further.
> >
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> s/reverted/inverted/

Thank you, Paul, for so fast review! I'll fix it in the next version
of the patchset.

>
> --
> Paul Barker
> Konsulko Group

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
