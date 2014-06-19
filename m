From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM on
 the B2020 Rev-E
Date: Thu, 19 Jun 2014 10:20:42 +0100
Message-ID: <20140619092042.GB26560@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
 <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, srinivas.kandagatla@gmail.com, thierry.reding@gmail.com
List-Id: linux-pwm@vger.kernel.org

> > All the infrastructure is now in place for ST's PWM controller.  Th=
is
> > patch takes the final step and enables the IP on the 2020 Rev-E
> > development platform.
>=20
> Why are you only enabling this for rev-E board?

Purely for testing purposes, as it's the only board I have.  If
anyone has the other revisions and would be happy to test the driver
for me then great.

> If you make the stih415 DT PWM nodes part of this series as well, the=
n=20
> assuming there is no good reason to the contary, the PWM could=20
> be enabled for both stih415/6 in the common stih41x-b2020 DTS file wh=
ich
> is also included by rev-E (assuming that PWM wiring is not some rev-E=
 specific
> thing).
>=20
> Also Ajit Signed-off-by needs adding to this series.

As you know, Thierry already picked this up.

Will fix for v2.

> After that:
> Acked-by: Peter Griffin <peter.griffin@linaro.org>

Thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
