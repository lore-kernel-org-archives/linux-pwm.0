From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] pwm: img: call pm_runtime_put in pm_runtime_get_sync
 failed case
Date: Mon, 1 Jun 2020 10:37:23 +0200
Message-ID: <166b2437-748a-1c1a-2b7f-e1163e4855d0@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:58225 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgFAIho (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 1 Jun 2020 04:37:44 -0400
Content-Language: en-GB
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Cc: Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>, Qiushi Wu <wu000273@umn.edu>, Stephen McCamant <smccaman@umn.edu>, Dinghao Liu <dinghao.liu@zju.edu.cn>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

> Even in failed case of pm_runtime_get_sync, the usage_count
> is incremented. In order to keep the usage_count with correct
> value call appropriate put.

* I suggest to adjust the word =E2=80=9Cusage_count=E2=80=9D in this chang=
e description.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mess=
age?

Regards,
Markus
