From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
Date: Mon, 25 Mar 2019 17:39:42 +0530
Message-ID: <CAJ2_jOFwDouMNAj8NxLX01bpLV+rG-rFsVh7e_e2ncCBX3qt_Q@mail.gmail.com>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <mvmimwotn60.fsf@suse.de> <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
 <mvm5zsgp00d.fsf@suse.de> <CAJ2_jOHoNnBF2UwU6G1vdvNrJAUJdGL_RncRAOaXMWoS03cagA@mail.gmail.com>
 <CAJ2_jOFrXcxRS1oYOuYhtuRReTocmPKnoe5GO_3r_B1uAZb+xA@mail.gmail.com> <mvmmuljupwd.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmmuljupwd.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 25, 2019 at 5:28 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 25 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > I have sent out the v11 patchset, you can test the heartbeat
> > application with that patchset.
> > You still need to make that DT file modification which you previously
> > did, using fsbl.bin
>
> Why can't the driver make use of sifive,approx-period?

Because as per the review comments and discussions, it has been
decided that the driver will make use of the conventional interface to
pass period settings instead of 'sifive,approx-period'.

For your reference:
https://lkml.org/lkml/2019/2/6/159

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
