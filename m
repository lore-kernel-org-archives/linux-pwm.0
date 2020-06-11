From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: Remove redundant 'maxItems'
Date: Thu, 11 Jun 2020 15:35:02 -0700
Message-ID: <159191490219.242598.961023303796459910@swboyd.mtv.corp.google.com>
References: <20200611194738.1480393-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20200611194738.1480393-1-robh@kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Quoting Rob Herring (2020-06-11 12:47:38)
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org> # clk
