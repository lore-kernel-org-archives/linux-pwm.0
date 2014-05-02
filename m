From: Jan Moskyto Matejka <mq@suse.cz>
Subject: [PATCH] [linux-next] pwm: lpss: fix const qualifier discard warning
Date: Fri,  2 May 2014 17:22:59 +0200
Message-ID: <1399044179-17912-1-git-send-email-mq@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jan Moskyto Matejka <mq@suse.cz>
List-Id: linux-pwm@vger.kernel.org

=46ixing this warning:
drivers/pwm/pwm-lpss.c: In function =E2=80=98pwm_lpss_probe_pci=E2=80=99=
:
drivers/pwm/pwm-lpss.c:192:2: warning: passing argument 3 of =E2=80=98p=
wm_lpss_probe=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from =
pointer target type [enabled by default]
  lpwm =3D pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
  ^
drivers/pwm/pwm-lpss.c:130:30: note: expected =E2=80=98struct pwm_lpss_=
boardinfo *=E2=80=99 but argument is of type =E2=80=98const struct pwm_=
lpss_boardinfo *=E2=80=99
 static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,

That warning was introduced in commit 093e00bb3f82f3c67e2d1682e316fc012=
bcd0d92
("pwm: lpss: Add support for PCI devices").

Signed-off-by: Jan Moskyto Matejka <mq@suse.cz>
---
 drivers/pwm/pwm-lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index c718ad1..c4620c1 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -129,6 +129,7 @@ static const struct pwm_ops pwm_lpss_ops =3D {
=20
 static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
 					    struct resource *r,
+					    const
 					    struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
--=20
1.8.4.5
