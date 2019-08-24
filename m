From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Date: Sat, 24 Aug 2019 02:26:34 +0200
Message-ID: <20190824002634.nfrhof3kpsrcc742@pengutronix.de>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
 <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Tue, Aug 20, 2019 at 05:56:40AM +0000, Anson Huang wrote:
> Gentle ping...

My impression[1] is that Thierry collects patches in bulk once or twice
per release cycle. The last two such bulks were between 5.2-rc6 and
5.2-rc7 and in the 5.2 merge window. So given we're at v5.3-rc5 now I
expect some action soon :-)

> > > From: Anson.Huang@nxp.com <Anson.Huang@nxp.com>
> > > Sent: Thursday, July 18, 2019 9:32 AM
> > >
> > > Use the new helper devm_platform_ioremap_resource() which wraps the
> > > platform_get_resource() and devm_ioremap_resource() together, to
> > > simplify the code.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > =

> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

[1] from git log --committer=3DThierry --format=3D%ci drivers/pwm | cut -d\=
  -f1 | uniq -c
-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
