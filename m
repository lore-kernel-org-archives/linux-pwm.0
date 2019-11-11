From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Allow compiling with COMPILE_TEST
Date: Mon, 11 Nov 2019 14:47:48 +0100
Message-ID: <f01b3443-9dcc-6485-4a05-a658d93326da@web.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111090357.13903-4-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Neil Brown <neilb@suse.de>, Neil Armstrong <narmstrong@baylibre.com>, kernel@pengutronix.de, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> The dependency on OMAP_DM_TIMER is only a runtime dependency. Also
> OMAP_DM_TIMER cannot be enabled without ARCH_OMAP being enabled.

Will a more =E2=80=9Cimperative mood=E2=80=9D become relevant also for thi=
s change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D31f4f5b495a62c9a8b15b1c358=
1acd5efeb9af8c#n151

Regards,
Markus
