From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date: Tue, 13 Nov 2018 10:00:58 -0800
Message-ID: <154213205843.88331.7023190778461777093@swboyd.mtv.corp.google.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, kernel@pengutronix.de, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pwm@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2018-11-13 01:52:10)
> =

> I wonder if it would make sense to introduce functions like:
> =

>         struct clk *clk_get_optional(struct device *dev, const char *id)
> =

> that return NULL instead of ERR_PTR(-ENODEV).
> =

> Then the above would simplify to:
> =

>         pc->clks[i] =3D devm_clk_get_optional(&pdev->dev, mtk_pwm_clk_nam=
e[i]);
>         if (IS_ERR(pc->clks[i]) {
>                 if (PTR_ERR(pc->clks[i]) =3D=3D -EPROBE_DEFER)
>                         dev_err(...);
>                 return PTR_ERR(pc->clks[i]);
>         }
> =

> (added the clk people to Cc for this question).
> =


Such a patch is already on the list and not getting much review.

http://lkml.kernel.org/r/1535724443-21150-1-git-send-email-phil.edworthy@re=
nesas.com
