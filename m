From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v8 0/2] PWM support for HiFive Unleashed
Date: Tue, 5 Mar 2019 13:55:41 +0530
Message-ID: <CAJ2_jOE=8_c6aN2FTQVt0wTpBAkL8BYyF3UFaMmqdvWYWAAmvg@mail.gmail.com>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com> <mvmfts228vu.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmfts228vu.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 4, 2019 at 4:39 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 01 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > This patch series adds a PWM driver and DT documentation
> > for HiFive Unleashed board. The patches are mostly based on
> > Wesley's patch.
>
> That doesn't appear to work with the heartbeat trigger, the led doesn't
> flash.

Make sure you modify the DTS file since with this patch the period is
now passed through the conventional way.
Example:
pwmleds {
    compatible =3D "pwm-leds";
    heartbeat {
        pwms =3D <&L45 0 100000 0>;
        max-brightness =3D <255>;
        linux,default-trigger =3D "heartbeat";
    };
};

I have tested the heartbeat trigger on HiFive Unleashed board and it's
working with this PWM patch.


>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
