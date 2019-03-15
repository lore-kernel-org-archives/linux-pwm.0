From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
Date: Fri, 15 Mar 2019 17:19:59 +0530
Message-ID: <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com> <mvmimwotn60.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmimwotn60.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 12, 2019 at 3:44 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 12 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > This patch series adds a PWM driver and DT documentation
> > for HiFive Unleashed board. The patches are mostly based on
> > Wesley's patch.
>
> Heartbeat trigger still doesn't work for me.

You need to make sure the period setting is passed via the
conventional way in DT file.
Example:
pwmleds {
    compatible =3D "pwm-leds";
    heartbeat {
        pwms =3D <&L45 0 10000000 0>;
        max-brightness =3D <255>;
        linux,default-trigger =3D "heartbeat";
    };
};

I have tested on HiFive unleashed board. To modify DT file I performed
the following steps:

Use the open-source FSBL from:
https://github.com/sifive/freedom-u540-c000-bootloader

Modify the fsbl/ux00_fsbl.dts file and re-build the fsbl.bin

Steps for using fsbl.bin in HiFive Unleashed board:
https://github.com/sifive/freedom-u540-c000-bootloader/issues/9

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
