From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/3] treewide: add vibrator support for various MSM SOCs
Date: Mon, 15 Oct 2018 17:52:49 -0700
Message-ID: <153965116919.5275.18169434559839796065@swboyd.mtv.corp.google.com>
References: <20180926235112.25710-1-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-soc@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, thierry.reding@gmail.com
Cc: masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
List-Id: linux-pwm@vger.kernel.org

Quoting Brian Masney (2018-09-26 16:51:09)
> This patch set adds support for the vibrator found on various Qualcomm
> MSM SOCs. This is based on work from:

Can you please stop adding 'treewide:' to your cover letters? It is very
confusing while reading over subject summaries to see something that
isn't actually treewide end up being qcom specific.
