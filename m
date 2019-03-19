From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
Date: Tue, 19 Mar 2019 11:56:35 +0530
Message-ID: <CAJ2_jOHoNnBF2UwU6G1vdvNrJAUJdGL_RncRAOaXMWoS03cagA@mail.gmail.com>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <mvmimwotn60.fsf@suse.de> <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
 <mvm5zsgp00d.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvm5zsgp00d.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 18, 2019 at 10:56 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 15 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > You need to make sure the period setting is passed via the
> > conventional way in DT file.
> > Example:
> > pwmleds {
> >     compatible =3D "pwm-leds";
> >     heartbeat {
> >         pwms =3D <&L45 0 10000000 0>;
> >         max-brightness =3D <255>;
> >         linux,default-trigger =3D "heartbeat";
> >     };
> > };
>
> I've now managed to build a working FSBL with that change, but that
> didn't change anything.  There is not even a heartbeat option in
> /sys/class/leds/heartbeat/trigger any more.

Below is the copy of the pwm nodes in my DTS file:

L45: pwm@10020000 {
        compatible =3D "sifive,pwm0";
        interrupt-parent =3D <&plic0>;
        interrupts =3D <42 43 44 45>;
        reg =3D <0x0 0x10020000 0x0 0x1000>;
        reg-names =3D "control";
        clocks =3D <&prci 3>;
        #pwm-cells =3D <2>;
};
L46: pwm@10021000 {
        compatible =3D "sifive,pwm0";
        interrupt-parent =3D <&plic0>;
        interrupts =3D <46 47 48 49>;
        reg =3D <0x0 0x10021000 0x0 0x1000>;
        reg-names =3D "control";
        clocks =3D <&prci 3>;
        #pwm-cells =3D <2>;
};
pwmleds {
        compatible =3D "pwm-leds";
        heartbeat {
                pwms =3D <&L45 0 10000000 0>;
                max-brightness =3D <255>;
                linux,default-trigger =3D "heartbeat";
        };
};

The above works for me.
I just noticed that I have been using pwm-cells =3D 2, instead of 3.
Maybe that is the problem here.
I will suggest you test it on v11 patch in which I will fix this
pwm-cells issue.

Thanks for pointing it out.

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
