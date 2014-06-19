From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM on
 the B2020 Rev-E
Date: Thu, 19 Jun 2014 12:22:39 +0100
Message-ID: <20140619112239.GC26560@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
 <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140619092042.GB26560@lee--X1>
 <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, srinivas.kandagatla@gmail.com, thierry.reding@gmail.com
List-Id: linux-pwm@vger.kernel.org

> > > Why are you only enabling this for rev-E board?
> >=20
> > Purely for testing purposes, as it's the only board I have.  If
> > anyone has the other revisions and would be happy to test the drive=
r
> > for me then great.
>=20
> Ok that's what I suspected.
>=20
> If you tell me how, I can test on a Rev C board. But as there are sev=
eral other=20
> revisions I think checking the board schematics would be the quickest=
 way forward.

Great.  Do you have a oscilloscope/logic analyser?

> > > If you make the stih415 DT PWM nodes part of this series as well,=
 then=20
> > > assuming there is no good reason to the contary, the PWM could=20
> > > be enabled for both stih415/6 in the common stih41x-b2020 DTS fil=
e which
> > > is also included by rev-E (assuming that PWM wiring is not some r=
ev-E specific
> > > thing).
>=20
> Can you add the stih415 bindings in V2 as well?

Who's using Orly1?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
