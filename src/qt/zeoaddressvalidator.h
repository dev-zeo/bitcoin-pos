// Copyright (c) 2011-2014 The coinBit Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef ZEO_QT_ZEOADDRESSVALIDATOR_H
#define ZEO_QT_ZEOADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class ZeoAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ZeoAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Zeo address widget validator, checks for a valid zeo address.
 */
class ZeoAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ZeoAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // ZEO_QT_ZEOADDRESSVALIDATOR_H
